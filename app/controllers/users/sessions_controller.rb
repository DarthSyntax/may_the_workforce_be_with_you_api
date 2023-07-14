# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  respond_to :json


  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  # def create
  #   super do |user|
  #     if request.format.json?
  #       data = {
  #         token: user.authentication_token,
  #         user: user.as_json
  #       }
  #       render json: data, status: :ok
  #       return
  #     end
  #   end
  # end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  private

  def respond_with(resource, options = {})

    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed in successfully'},
        data: current_user
      }, status: :ok
    else
      render json: {
        status: {code: 404, message: 'User could not be signed in'},
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
    Rails.application.credentials.fetch(:secret_key_base)).first

    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        status: 200,
        message: 'Signed out successfully'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: 'User has no active session'
      }, status: :unauthorized
    end
  end

end

