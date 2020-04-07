class ShiftJob < ApplicationRecord
  belongs_to :job
  belongs_to :shift
end
