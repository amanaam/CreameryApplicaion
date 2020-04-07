require "test_helper"

describe Job do
  let(:job) { Job.new }

  it "must be valid" do
    value(job).must_be :valid?
  end
end
