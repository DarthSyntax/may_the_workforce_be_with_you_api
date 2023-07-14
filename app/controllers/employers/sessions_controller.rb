# frozen_string_literal: true

class Employers::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:employer_name])
  end

  def respond_with(resource, options = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Sign In Successful'}
        data: current_employer
      }, status: :ok
    else
      render json: {
        status:{ code: 404, errors: resource.errors.full_messages}
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy(resource, options = {})
    jwt_paylod = JTW.decode(request.headers['Authorization'].split(' ')[1],
      Rails.application.credentials.fetch(:secret_key_base)).first

    current_user = jwt_payload['sub']

    if current_user
      render json: {
        status: 200,
        message: 'Employer Signed Out Successfully'
       }, status: :ok
    else
      render json: {
        status: 401,
        message: 'Employer Session Not Active'
      }, status: :unauthorized
    end
  end

end
