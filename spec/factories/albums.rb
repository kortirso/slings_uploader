FactoryBot.define do
  factory :album do
    identifier 12_345_678
    name 'Just Name'
    association :vk_group
  end
end
