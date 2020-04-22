class PayGrade < ApplicationRecord
  has_many :assignments
  has_many :pay_grade_rates
  validates_presence_of :level
  
  scope :alphabetical,    -> { order('level') }
  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where.not(active: true) }
  
  before_destroy :is_destroyable
  
  def make_active
    self.active = true
    self.save!
  end

  def make_inactive
    self.active = false
    self.save!
  end
  
  private
  def is_destroyable
    throw(:abort)
  end

end
