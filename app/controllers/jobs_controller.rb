class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource
  
  def index
    unless current_user.role?(:employee)
        @jobs = Job.all.paginate(page: params[:page]).per_page(5)
    end
  end
  
  def create
    if current_user.role?(:admin)
        @job = Job.new(job_params)
        if @job.save
          redirect_to @job, notice: "Successfully added job to the system."
        else
          render action: 'new'
        end
    end
  end

  def new
    unless current_user.role?(:employee)
      @job = Job.new
    end
  end

  def show
  end

  def update
    unless current_user.role?(:employee)
        if @job.update(job_params)
          redirect_to job_path(@job), notice: "job successfully updated."
        else
          render action: 'edit'
        end
    end
  end
  
  def edit
  end
  
  def destroy
    unless current_user.role?(:employee)
        @job.destroy
        flash[:notice] = "Job successfully removed."
        redirect_to jobs_url
    end
  end
  
  private
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:name, :description, :active)
  end
end
