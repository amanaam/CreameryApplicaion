class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :details]
  before_action :check_login
  authorize_resource 
  def index
      unless current_user.role?(:employee)
          @active_managers = Employee.managers.active.paginate(:page => params[:page]).per_page(5)
          @active_employees = Employee.regulars.active.paginate(:page => params[:page]).per_page(5)
          @inactive_employees = Employee.inactive.paginate(:page => params[:page]).per_page(5)
      end
  end
  
  def details
  end
  

  def edit
      if current_user.role?(:admin)
          @employee = Employee.find(params[:id])
      end
  end

  def new
      if current_user.role?(:admin)
        @employee = Employee.new
      end
  end
  
  def create
      if current_user.role?(:admin)
          @employee = Employee.new(employee_params)
          if @employee.save
              redirect_to @employee, notice: "Successfully added #{@employee.proper_name} as an employee."
          else
              render action: 'new'
          end
      end
  end
  
  def update
      unless current_user.role?(:employee)
          @employee = Employee.find(params[:id])
          if @employee.update(employee_params)
              redirect_to @employee, notice: "Updated #{@employee.proper_name}'s information."
          else
              render action: 'edit'
          end
      end
  end
  
  def destroy
      if current_user.role?(:admin)
          @employee = Employee.find(params[:id])
          @employee.destroy
          flash[:notice] = "Removed assignment from the system."
          redirect_to employees_url
      end
  end
  
  def show
      @current_assignment = @employee.current_assignment
      @previous_assignments = @employee.assignments.to_a - [@current_assignment]
      @upcoming_shifts = Shift.for_employee(@employee).for_next_days(7).chronological.paginate(:page => params[:page]).per_page(5)
      @past_shifts = Shift.for_employee(@employee).for_past_days(7).chronological.paginate(:page => params[:page]).per_page(5)
  end
  
  private
    def set_employee
        @employee = Employee.find(params[:id])
    end
  
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :active, :username, :password, :password_confirmation)
    end
end
