require "test_helper"

class EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee = FactoryBot.create(:employee)
  end

  test "should get index" do
    get employees_path
    assert_response :success
    assert_not_nil assigns(:active_managers)
    assert_not_nil assigns(:active_employees)
    assert_not_nil assigns(:inactive_employees)
  end

  test "should show employee" do
    store = FactoryBot.create(:store)
    assign = FactoryBot.create(:assignment, employee: @employee, store: store, end_date: nil)
    get employee_path(@employee)
    assert_response :success
    assert_not_nil assigns(:current_assignment)
    assert_not_nil assigns(:previous_assignments)
  end

  test "should get new" do
    get new_employee_path
    assert_response :success
  end

  test "should create employee when appropriate" do
    # create works
    assert_difference('Employee.count') do
      post employees_path, params: { employee: { first_name: 'Ezra', last_name: 'Bridger',  ssn: '037201234', phone: '4122683259', date_of_birth: 19.years.ago.to_date, role: 'employee', active: true } }
    end
    assert_equal "Successfully added Ezra Bridger as an employee.", flash[:notice]
    assert_redirected_to employee_path(Employee.last)
  end

  test "should not create employee when inappropriate" do
    # create invalid
    post employees_path, params: { employee: { first_name: nil, last_name: 'Bridger',  ssn: '037201234', phone: '4122683259', date_of_birth: 19.years.ago.to_date, role: 'employee', active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_employee_path(@employee)
    assert_response :success
  end

  test "should update employee when appropriate" do
    # update valid
    patch employee_path(@employee), params: { employee: { first_name: 'Mark', last_name: 'Heimann',  ssn: '037201234', phone: '4122683259', date_of_birth: 26.years.ago.to_date, role: 'employee', active: true } }
    assert_equal "Updated Mark Heimann's information.", flash[:notice]
    assert_redirected_to employee_path(@employee)
  end

  test "should not update employee when inappropriate" do
    # update invalid
    patch employee_path(@employee), params: { employee: { first_name: 'Mark', last_name: nil,  ssn: '037201234', phone: '4122683259', date_of_birth: 26.years.ago.to_date, role: 'employee', active: true } }
    assert_template :edit
  end

  test "should not have the ability to destroy employees" do
    delete employee_path(@employee)
    assert_response :missing
  end

end