class PayGradeRatesController < ApplicationController
  before_action :set_pay_grade_rate, only: [:show, :edit, :update]
  before_action :check_login
  authorize_resource 
  
  def index
    if current_user.role?(:admin)
        @pay_grade_rates = PayGradeRate.all.paginate(page: params[:page]).per_page(5)
    end
  end

  def new
      @pay_grade_rate = PayGradeRate.new
  end

  def create
    if current_user.role?(:admin)
        @pay_grade_rate = PayGradeRate.new(pay_grade_rate_params)
        if @pay_grade_rate.save
          redirect_to @pay_grade_rate, notice: "Successfully added pay grade rate to the system."
        else
          render action: 'new'
        end
    end
  end
  
  
  private
    def set_pay_rate_grade
      if current_user.role?(:admin)
        @pay_grade_rate = PayGradeRate.find(params[:id])
      end
    end
  
    def pay_grade_rate_params
      params.require(:pay_grade_rate).permit(:pay_grade_id, :rate, :start_date, :end_date)
    end
end