require "test_helper"

describe PayGradeRate do
  let(:pay_grade_rate) { PayGradeRate.new }

  it "must be valid" do
    value(pay_grade_rate).must_be :valid?
  end
end
