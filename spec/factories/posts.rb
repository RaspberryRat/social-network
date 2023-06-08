FactoryBot.define do
  factory :post do
    association :author, factory: :user
    association :postable, factory: :text_post

    before(:create) do |post|
      create(:text_post)
    end
  end
end
