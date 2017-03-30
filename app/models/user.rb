class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

    has_many :identities
    has_one :site
    has_one :vk_group

    after_create :create_sites_objects

    def self.find_for_oauth(auth)
        identity = Identity.find_for_oauth(auth)
        if identity.present?
            identity.user.update(token: auth.credentials[:token])
            return identity.user
        end

        user = User.find_by(email: auth.info[:email])
        if user.nil?
            user = User.create(email: auth.info[:email], password: Devise.friendly_token[0,20], token: auth.credentials[:token])
        else
            user.update(token: auth.credentials[:token])
        end
        user.identities.create(provider: auth.provider, uid: auth.uid)

        user
    end

    private

    def create_sites_objects
        Site.create user: self
        VkGroup.create user: self
    end
end
