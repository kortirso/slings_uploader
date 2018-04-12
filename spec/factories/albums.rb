FactoryBot.define do
  factory :album do
    album_id 12_345_678
    album_name 'Just Name'
    association :vk_group
  end
end
