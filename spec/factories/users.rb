FactoryBot.define do
  factory :user do
    username { Faker::Name.name[3..20] }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
