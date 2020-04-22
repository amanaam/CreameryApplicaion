class PayGrade < ApplicationRecord
  has_many :assignments
  has_many :pay_grade_rates
  validates_presence_of :level
end
