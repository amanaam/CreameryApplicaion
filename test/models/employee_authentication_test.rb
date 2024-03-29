require 'test_helper'

class EmployeePaymentTest < ActiveSupport::TestCase
  context "Given context" do
    setup do 
      create_employees
    end

    should "require users to have unique, case-insensitive usernames" do
      assert_equal "alex", @alex.username
      # try to switch to Cindy's username 'cindy'
      @alex.username = "CINDY"
      deny @alex.valid?, "#{@alex.username}"
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:employee, first_name: "Mark", username: "mark", last_name: "Heimann", role: "admin", password: nil)
      deny bad_user.valid?
    end

    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:employee, first_name: "Mark", username: "mark", last_name: "Heimann", role: "admin", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:employee, first_name: "Mark", username: "mark", last_name: "Heimann", role: "admin", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end

    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:employee, first_name: "Mark", username: "mark", last_name: "Heimann", role: "admin", password: "no", password_confirmation: "no")
      deny bad_user.valid?
    end

    should "have class method to handle authentication services" do
      assert Employee.authenticate('alex', 'secret')
      deny Employee.authenticate('alex', 'notsecret')
    end

    should "have role methods and recognize all three roles" do
      assert @cindy.role?(:employee)
      deny @cindy.role?(:manager)
      deny @cindy.role?(:admin)
      assert @kathryn.role?(:manager)
      deny @kathryn.role?(:admin)
      deny @kathryn.role?(:employee)
      assert @alex.role?(:admin)
      deny @alex.role?(:manager)
      deny @alex.role?(:employee)
    end

  end
end