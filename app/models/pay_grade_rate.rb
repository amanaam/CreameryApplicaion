class PayGradeRate < ApplicationRecord
  belongs_to :pay_grade
  
  before_destroy :is_destroyable
  
  validates_numericality_of :rate, :greater_than =>0
  
  scope :current,       -> { where('end_date IS NULL') }
  scope :chronological, -> { order('start_date') }
  scope :for_date,      ->(date) { where("start_date <= ?", date) }
  scope :for_pay_grade, -> (pay_grade){where('pay_grade_id == ?', pay_grade.id)}
  
  private
  def is_destroyable
    throw(:abort)
  end

end
