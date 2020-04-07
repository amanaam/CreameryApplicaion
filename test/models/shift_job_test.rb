require "test_helper"

describe ShiftJob do
  let(:shift_job) { ShiftJob.new }

  it "must be valid" do
    value(shift_job).must_be :valid?
  end
end
