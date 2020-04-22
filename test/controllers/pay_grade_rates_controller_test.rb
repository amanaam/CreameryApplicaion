require "test_helper"

describe PayGradeRatesController do
  it "should get new" do
    get pay_grade_rates_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get pay_grade_rates_edit_url
    value(response).must_be :success?
  end

  it "should get show" do
    get pay_grade_rates_show_url
    value(response).must_be :success?
  end

  it "should get index" do
    get pay_grade_rates_index_url
    value(response).must_be :success?
  end

end
