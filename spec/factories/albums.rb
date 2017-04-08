FactoryGirl.define do
    factory :album do
        album_id 12345678
        album_name 'Just Name'
        association :vk_group
    end
end
