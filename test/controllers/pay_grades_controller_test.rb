require "test_helper"

describe PayGradesController do
  it "should get new" do
    get pay_grades_new_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get pay_grades_edit_url
    value(response).must_be :success?
  end

  it "should get show" do
    get pay_grades_show_url
    value(response).must_be :success?
  end

  it "should get index" do
    get pay_grades_index_url
    value(response).must_be :success?
  end

end
