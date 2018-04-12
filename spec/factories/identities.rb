FactoryBot.define do
  factory :identity do
    uid 1_234_567_890
    provider 'vkontakte'
    association :user
  end
end
