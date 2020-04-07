FactoryBot.define do
  factory :shift do
    assignment { nil }
    date { "2020-04-07" }
    start_time { "2020-04-07 21:48:49" }
    end_time { "2020-04-07 21:48:49" }
    notes { "MyText" }
    status { "MyString" }
  end
end
