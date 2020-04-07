require "test_helper"

describe PayGrade do
  let(:pay_grade) { PayGrade.new }

  it "must be valid" do
    value(pay_grade).must_be :valid?
  end
end
