FactoryGirl.define do
    factory :publish do
        association :user
        association :product
        association :album
    end
end
