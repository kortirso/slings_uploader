FactoryBot.define do
    factory :publish do
        association :user
        association :product
    end
end
