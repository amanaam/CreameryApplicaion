class AddDefaultEmployee < ActiveRecord::Migration[5.2]
  def up
    admin = Employee.new
    admin.first_name = "Admin"
    admin.last_name = "Admin"
    admin.ssn = "999847875"
    admin.date_of_birth = 19.years.ago.to_date
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.username = "amanaam"
    admin.active = true
    admin.phone = "1360539782"
    admin.save
  end
  def down
    admin = Employee.find_by_username "amanaam"
    User.delete admin
  end
end