FactoryBot.define do
  factory :oauth, class: OmniAuth::AuthHash do
    provider 'vkontakte'
    uid { '1234567890' }
    info { build(:oauth_info) }

    trait :with_credentials do
      credentials { build(:oauth_credentials) }
    end
  end

  factory :oauth_info, class: OmniAuth::AuthHash::InfoHash do
    email { 'test@email.com' }
    first_name { 'test_first_name' }
    last_name { 'test_last_name' }
  end

  factory :oauth_credentials, class: OmniAuth::AuthHash do
    expires true
    expires_at { 2.months.from_now.to_i }
    token { SecureRandom.base58 161 }
  end
end
