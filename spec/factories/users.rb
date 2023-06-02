FactoryBot.define do
  factory :user do
    first_name { Faker::Name.name[3..20] }
    last_name { Faker::Name.name[3..20] }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
