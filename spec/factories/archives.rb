FactoryBot.define do
  factory :archive do
    identifier 123
    association :vk_group

    trait :without_album do
      identifier nil
    end
  end
end
