FactoryBot.define do
    factory :identity do
        uid 1234567890
        provider 'vkontakte'
        association :user
    end
end
