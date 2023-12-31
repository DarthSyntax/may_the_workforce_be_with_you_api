class JobsController < ApplicationController
  before_action :set_job, only: %i[ show update destroy ]

  # GET /jobs
  def index
    @jobs = Job.all

    render json: @jobs
  end

  # GET /jobs/1
  def show
    @job = Job.find(params[:id])
    render json: {job: @job, users: @job.users }

  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    logged_in_employer = Employer.find(params[:employer_id])
    logged_in_employer.jobs << @job

    if @job.save
      render json: @job, status: :created, location: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # POST /jobs/1/apply
  def apply
    @job = Job.find(params[:id])
    candidate = User.all.find {|user| user.full_name == params[:full_name]}
    if @job && !(@job.users.include?(candidate))
      @job.users << candidate
      render json: {job: @job, candidate: candidate}
    else
      render json: {
        status: 400,
        message: "#{candidate.full_name} has already applied to this job"
       }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  # DELETE /jobs/1
  def destroy
    @job.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_params
      params.require(:job).permit(:title, :description, :salary, :exp_level)
    end
end
