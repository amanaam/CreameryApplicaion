class Shift < ApplicationRecord
  belongs_to :assignment
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  has_one :store, through: :assignment
  has_one :employee, through: :assignment
  
  validates_presence_of :date, :start_time, :assignment_id
  validates_date :date, :on_or_after => lambda { :s_time }, on_or_after_message: 'must be on or after the assignment starts'
  validates_time :start_time
  validates_time :end_time, after: :start_time, allow_blank: :true
  validate :can_create
  validates_inclusion_of :status, in: %w[pending finished started], message: "is not an option"
  
  scope :completed,      -> {joins(:shift_jobs).group(:shift_id)}
  scope :incomplete,     -> {joins('left join shift_jobs on shifts.id = shift_jobs.shift_id').where('shift_jobs.job_id is NULL')}
  scope :for_store,      -> (store_id) {joins(:assignment, :store).where("assignments.store_id = ?", store_id)}
  scope :for_employee,   -> (employee_id) {joins(:assignment, :employee).where("assignments.employee_id = ?", employee_id)}
  scope :past,           -> {where('date < ?', Date.today)}
  scope :upcoming,       -> {where('date >= ?', Date.today)}
  scope :pending,        -> {where('status == ?', "pending")}
  scope :started,        -> {where('status == ?', "started")}
  scope :finished,       -> {where('status == ?', "finished")}
  scope :for_next_days,  -> (x) {where('date <= ? AND date >= ?', x.days.from_now.to_date, Date.today) }
  scope :for_past_days,  -> (x) {where('date >= ? AND date < ?', x.days.ago.to_date, Date.today) }
  scope :chronological,  -> {order('date', 'start_time')}
  scope :by_store,       -> {joins(:assignment, :store).order('stores.name')}
  scope :by_employee,    -> {joins(:assignment, :employee).order('employees.last_name, employees.first_name')}
  scope :for_dates,      -> (x) {where('date >= ? AND date <= ?', x.start_date, x.end_date)}
  
  before_create :add_end_time
  before_destroy :is_destroyable
  
  def report_completed?
    if (self.shift_jobs.count > 0)
      true
    else
      false
    end
  end
  
  def duration
    (self.end_time - self.start_time)/3600
  end
    
  
  private
  
  def s_time
      self.assignment.start_date.to_date
  end
  def add_end_time
    if (self.end_time == nil)
      self.end_time = self.start_time + 3.hours
    end
  end
  
  def can_create
    unless (self.assignment.nil? or self.assignment.end_date.nil?)
        errors.add(:assignment_id, 'Assignment is not current')
    end
  end

  
  def is_destroyable
      if (self.status == 'pending')
          true
      elsif (self.status == 'started' or self.status == 'finished')
          throw(:abort)
      end
  end
end
