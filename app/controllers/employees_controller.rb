class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :details]
  before_action :check_login
  authorize_resource 
  def index
      @active_managers = Employee.managers.active.paginate(:page => params[:page]).per_page(5)
      @active_employees = Employee.regulars.active.paginate(:page => params[:page]).per_page(5)
      @inactive_employees = Employee.inactive.paginate(:page => params[:page]).per_page(5)
  end
  
  def details
  end
  

  def edit
  end

  def new
      @employee = Employee.new
  end
  
  def create
      @employee = Employee.new(employee_params)
      if @employee.save
          redirect_to @employee, notice: "Successfully added #{@employee.proper_name} as an employee."
      else
          render action: 'new'
      end
  end
  
  def update
      if @employee.update(employee_params)
          redirect_to @employee, notice: "Updated #{@employee.proper_name}'s information."
      else
          render action: 'edit'
      end
  end
  
  def show
      @current_assignment = @employee.current_assignment
      @previous_assignments = @employee.assignments.to_a - [@current_assignment]
  end
  
  private
    def set_employee
        @employee = Employee.find(params[:id])
    end
  
    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :ssn, :phone, :date_of_birth, :role, :active, :username, :password, :password_confirmation)
    end
end
