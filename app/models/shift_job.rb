class ShiftJob < ApplicationRecord
  belongs_to :job
  belongs_to :shift
  
  validates_presence_of :shift_id, :job_id
  validate :can_create
  
  scope :alphabetical, -> { joins(:job).order('name') }
  
  private
  def can_create
      if (self.shift.nil? or self.shift.date > Date.current)
          errors.add(:shift_job_id, "can not add to future shift.")
      else
          true
      end
  end
end
