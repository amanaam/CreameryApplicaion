module Populator
  module Assignments

    def create_assignments_for(all_employees)
      count = 0
      all_employees.each do |employee|
        count += 1
        puts " -- created assignments for #{count} employees" if (count % 10).zero?
        option = rand(3)
        all_stores = Store.all.shuffle
        case option
        when 0  # just one assignment, 6..12 months ago
          store1 = all_stores.pop
          starting = rand(6..12)
          assignment1 = FactoryBot.create(:assignment, employee: employee, store: store1, start_date: starting.months.ago.to_date, end_date: nil)
        when 1  # two assignments, first 24 months ago, second 6..12 months ago         
          store1 = all_stores.pop                                                       
          assignment1 = FactoryBot.create(:assignment, employee: employee, store: store1, start_date: 24.months.ago.to_date, end_date: nil)
          store2 = all_stores.pop                                                       
          starting = rand(6..12)                                                        
          assignment2 = FactoryBot.create(:assignment, employee: employee, store: store2, start_date: starting.months.ago.to_date, end_date: nil)
        when 2 # three assignments, first 24 months ago, second 9..15 months ago, third 1..3 months ago with pay upgrade
          store1 = all_stores.pop
          assignment1 = FactoryBot.create(:assignment, employee: employee, store: store1, start_date: 24.months.ago.to_date, end_date: nil)
          store2 = all_stores.pop                                                       
          starting = rand(9..15)                                                        
          assignment2 = FactoryBot.create(:assignment, employee: employee, store: store2, start_date: starting.months.ago.to_date, end_date: nil)
          store3 = all_stores.pop                                                       
          starting3 = rand(2..4)                                                        
          assignment3 = FactoryBot.create(:assignment, employee: employee, store: store3, start_date: starting3.months.ago.to_date, end_date: nil)
        end
      end
    end
  end
end