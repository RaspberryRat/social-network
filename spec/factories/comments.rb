FactoryBot.define do
  factory :comment do
    content { "Sample content" }
    association :author, factory: :user
    association :post
  end
end
