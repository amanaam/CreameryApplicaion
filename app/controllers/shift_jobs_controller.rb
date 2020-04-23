class ShiftJobsController < ApplicationController
  before_action :check_login
  authorize_resource
  def new
      unless current_user.role? :employee
          @shift_job = ShiftJob.new
      end
  end
  
  def create
        unless current_user.role?(:employee)
            @shift_job = ShiftJob.new(shift_job_params)
            if @shift_job.save
              redirect_to employees_path, notice: "Successfully added Job to the Shift in the system."
            else
              render action: 'new'
            end
        end
  end
    
  def shift_job_params
    params.require(:shift_job).permit(:shift_id, :job_id)
  end
end