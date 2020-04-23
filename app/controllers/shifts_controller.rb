class ShiftsController < ApplicationController
  before_action :set_shift, only: [:show, :edit, :update, :destroy]
  before_action :check_login
  authorize_resource
  
  def index
    unless current_user.role?(:employee)
        @upcoming_shifts = Shift.upcoming.by_store.chronological.paginate(page: params[:page]).per_page(5)
    	@past_shifts = Shift.past.by_store.chronological.paginate(page: params[:page]).per_page(5)
    	@completed_shifts = Shift.completed.by_store.chronological.paginate(page: params[:page]).per_page(5)
    else
        @upcoming_shifts = Shift.upcoming.for_employee(current_user.employee_id)
        @past_shifts = Shift.past.for_employee(current_user.employee_id)
        @completed_shifts = Shift.completed.for_employee(current_user.employee_id)
    end
  end
  
  def create
    unless current_user.role?(:employee)
        @shift = Shift.new(shift_params)
        if @shift.save
          redirect_to @shift, notice: "Successfully added shift to the system."
        else
          render action: 'new'
        end
    end
  end

  def new
    unless current_user.role?(:employee)
      @shift = Shift.new
    end
  end

  def show
      unless current_user.role?(:employee)
          @jobs = @shift.jobs.paginate(page: params[:page]).per_page(5)
      end
  end

  def update
    unless current_user.role?(:employee)
        if @shift.update(shift_params)
          redirect_to shift_path(@shift), notice: "Shift successfully updated."
        else
          render action: 'edit'
        end
    end
  end
  
  def edit
  end
  
  def destroy
    unless current_user.role?(:employee)
        @shift.destroy
        redirect_to shifts_path, notice: "Shift successfully removed."
    end
  end
  
  private
  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:assignment_id, :date, :start_time, :end_time, :notes, :status)
  end
end

