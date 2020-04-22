require "test_helper"

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_admin
    @store = FactoryBot.create(:store)
  end

  test "should get index" do
    get stores_path
    assert_response :success
    assert_not_nil assigns(:active_stores)
    assert_not_nil assigns(:inactive_stores)
  end

  test "should show store" do
    get store_path(@store)
    assert_response :success
    assert_not_nil assigns(:current_managers)
    assert_not_nil assigns(:current_employees)
  end

  test "should get new" do
    get new_store_path
    assert_response :success
  end

  test "should create store when appropriate" do
    # create valid
    assert_difference('Store.count') do
      post stores_path, params: { store: { name: 'North Hills', street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    end
    assert_redirected_to store_path(Store.last)
  end

  test "should not create store when inappropriate" do
    # create invalid
    post stores_path, params: { store: { name: nil, street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    assert_template :new
  end

  test "should get edit" do
    get edit_store_path(@store)
    assert_response :success
  end

  test "should update store when appropriate" do
    # update valid
    patch store_path(@store), params: { store: { name: 'North Hills', street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    assert_equal "Updated store information for North Hills.", flash[:notice]
    assert_redirected_to store_path(@store)
  end

  test "should not update store when inappropriate" do
    # update invalid
    patch store_path(@store), params: { store: { name: nil, street: 'Sudberry Dr', city: 'Wexford',  state: 'PA', zip: '15090', phone: '7242682323', active: true } }
    assert_template :edit
  end

  test "should not have the ability to destroy stores" do
    delete store_path(@store)
    assert_response :missing
  end

end
