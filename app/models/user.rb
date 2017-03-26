class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

    has_many :identities

    def self.find_for_oauth(auth)
        identity = Identity.find_for_oauth(auth)
        return identity.user if identity.present?
        email = auth.info[:email]
        user = User.find_by(email: email)
        user = User.create(email: email, password: Devise.friendly_token[0,20]) if user.nil?
        user.identities.create(provider: auth.provider, uid: auth.uid)
        user
    end
end
