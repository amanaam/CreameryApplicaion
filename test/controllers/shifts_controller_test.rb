require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
  end

  describe ShiftsController do
    
    
  it "should get index" do
    get shifts_index_url
    value(response).must_be :success?
  end

  it "should get new" do
    get shifts_new_url
    value(response).must_be :success?
  end

  it "should get show" do
    get shifts_show_url
    value(response).must_be :success?
  end

  it "should get edit" do
    get shifts_edit_url
    value(response).must_be :success?
  end
  end

end
