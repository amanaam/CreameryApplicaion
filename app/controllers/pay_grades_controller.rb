class PayGradesController < ApplicationController
  before_action :set_pay_grade, only: [:show, :edit, :update]
  before_action :check_login
  authorize_resource 
  
  def index
    if current_user.role?(:admin)
        @pay_grades = PayGrade.all.alphabetical.paginate(page: params[:page]).per_page(5)
    end
  end

  def new
      if current_user.role?(:admin)
        @pay_grade = PayGrade.new
      end
  end

  def edit
  end
  
  def create
    if current_user.role?(:admin)
        @pay_grade = PayGrade.new(pay_grade_params)
        if @pay_grade.save
          redirect_to @pay_grade, notice: "Successfully added pay grade to the system."
        else
          render action: 'new'
        end
    end
  end
  
  def update
    if current_user.role?(:admin)
        if @pay_grade.update(pay_grade_params)
          redirect_to pay_grade_path(@pay_grade), notice: "pay grade successfully updated."
        else
          render action: 'edit'
        end
    end
  end
  
  private
    def set_pay_grade
      if current_user.role?(:admin)
        @pay_grade = PayGrade.find(params[:id])
      end
    end
  
    def pay_grade_params
      params.require(:pay_grade).permit(:level, :active)
    end
end