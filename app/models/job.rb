class Job < ApplicationRecord
  has_many :shift_jobs
  has_many :shifts, through: :shift_jobs
    
  validates_presence_of :name  
      
  scope :alphabetical,    -> { order('name') }
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
    if not (self.shift_jobs.empty?)
      throw(:abort)
    else
        true
    end
  end
end
