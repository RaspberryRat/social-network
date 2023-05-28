FactoryBot.define do
  factory :post do
    content { "Sample content" }
    association :author, factory: :user
  end
end
