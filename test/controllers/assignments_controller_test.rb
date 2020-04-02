require "test_helper"

class AssignmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = FactoryBot.create(:store)
    @employee = FactoryBot.create(:employee)
    @assignment = FactoryBot.create(:assignment, store: @store, employee: @employee, end_date: nil)
  end

  test "should get index" do
    get assignments_path
    assert_response :success
    assert_not_nil assigns(:current_assignments)
    assert_not_nil assigns(:past_assignments)
  end

  test "should get new" do
    get new_assignment_path
    assert_response :success
  end

  test "should create assignment when appropriate" do
    # create valid
    assert_difference('Assignment.count') do
      @employee2 = FactoryBot.create(:employee, first_name: 'Fred')
      post assignments_path, params: { assignment: { store_id: @store.id, employee_id: @employee2.id, start_date: Date.yesterday, end_date: nil } }
    end
    assert_equal "Successfully added the assignment.", flash[:notice]
    assert_redirected_to assignments_path
  end

  test "should not create assignment when inappropriate" do
    # create invalid
    post assignments_path, params: { assignment: { store_id: @store.id, employee_id: nil, start_date: Date.yesterday, end_date: nil } }
    assert_template :new
  end

  test "should terminate assignment" do
    assert_nil @assignment.end_date
    patch terminate_assignment_path(@assignment)
    @assignment.reload
    puts @assignment.end_date
    assert_equal Date.current, @assignment.end_date
    assert_redirected_to assignments_path
  end

  test "should destroy assignment when appropriate" do
    assert_difference('Assignment.count', -1) do
      delete assignment_path(@assignment)
    end
    assert_equal "Removed assignment from the system.", flash[:notice]
    assert_redirected_to assignments_path
  end

  test "should not have the ability to edit or update assignments" do
    get edit_assignment_path(@assignment)
    assert_response :missing
    patch assignment_path(@assignment)
    assert_response :missing
  end

end

