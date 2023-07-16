class EmployersController < ApplicationController

  def index
    @employers = Employer.all
    render json: @employers
  end

  def show
    @employer = Employer.find(params[:id])
    render json: {employer: @employer, jobs: @employer.jobs}
  end
end
