class Shift < ApplicationRecord
  belongs_to :assignment
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  has_one :store, through: :assignment
  has_one :employee, through: :assignment
  
  validates_presence_of :date, :start_time
  validates_date :date, :on_or_after => lambda { self.assignment.start_date.to_date }, on_or_after_message: 'must be on or after the assignment starts'
  validates_time :start_time
  validates_time :end_time, after: :start_time, allow_blank: :true
  
  scope :completed,      -> {joins(:shift_jobs).group(:shift_id)}
  scope :incomplete,     -> {joins('left join shift_jobs on shifts.id = shift_jobs.shift_id').where('shift_jobs.job_id is NULL')}
  scope :for_store,      -> (store_id) {joins(:assignment, :store).where("assignments.store_id = ?", store_id)}
  scope :for_employee,   -> (employee_id) {joins(:assignment, :employee).where("assignments.employee_id = ?", employee_id)}
  scope :past,           -> {where('date < ?', Date.today)}
  scope :upcoming,       -> {where('date >= ?', Date.today)}
  scope :pending,        -> {where('status == ?', "pending")}
  scope :started,        -> {where('status == ?', "started")}
  scope :finished,       -> {where('status == ?', "finished")}
  scope :for_next_days,  -> (x) {where('date <= ? AND date >= ', x.days.from_now.to_date, Date.today) }
  scope :for_past_days,  -> (x) {where('date <= ? AND date >= ', x.days.ago.to_date, Date.today) }
  scope :chronological,  -> {order('date')
  scope :by_store,       -> {joins(:assignment, :store).order('stores.name')}
  scope :by_employee,    -> {joins(:assignment, :employee).order('employee.last_name, employee.first_name')}
  
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
    
  before_create :add_end_time
  
  private
  
  def add_end_time
    if (self.end_time == nil)
      self.end_time = self.start_time + 3.hours
    end
  end
end
