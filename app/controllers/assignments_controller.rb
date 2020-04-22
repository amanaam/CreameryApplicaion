class AssignmentsController < ApplicationController
  before_action :check_login
  authorize_resource 
  def index
      @current_assignments=Assignment.current.paginate(:page => params[:page]).per_page(5)
      @past_assignments=Assignment.past.paginate(:page => params[:page]).per_page(5)
  end

  def new
      @assignment = Assignment.new
  end
  
  def create
      @assignment = Assignment.new(assignment_params)
      if @assignment.save
          redirect_to assignments_url, notice: "Successfully added the assignment."
      else
          render action: 'new'
      end
  end
  
  def terminate
    @assignment = Assignment.find(params[:id])
    if @assignment.terminate
      redirect_to assignments_path, notice: "Assignment for #{@assignment.employee.proper_name} terminated."
    end
  end
      
  def destroy
      @assignment = Assignment.find(params[:id])
      @assignment.destroy
      flash[:notice] = "Removed assignment from the system."
      redirect_to assignments_url
  end
  private
    def assignment_params
      params.require(:assignment).permit(:store_id, :employee_id, :pay_grade_id, :start_date, :end_date)
    end
end
