FactoryBot.define do
  factory :archive do
    album_id 123
    association :vk_group

    trait :without_album do
      album_id nil
    end
  end
end
