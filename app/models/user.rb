class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

    has_many :identities, dependent: :destroy
    has_many :publishes, dependent: :destroy
    
    has_one :site, dependent: :destroy
    has_one :vk_group, dependent: :destroy
    has_many :albums, through: :vk_group

    validates :role, presence: true, inclusion: { in: %w(user admin) }

    after_create :create_sites_objects

    def self.find_for_oauth(auth)
        identity = Identity.find_for_oauth(auth)
        if identity.present?
            identity.user.update(token: auth.credentials[:token])
            return identity.user
        end

        email = auth.info[:email].empty? ? "#{auth.info[:name].downcase.split(' ').join('_')}@app.ru" : auth.info[:email]

        user = User.find_by(email: email)
        if user.nil?
            user = User.create(email: email, password: Devise.friendly_token[0,20], token: auth.credentials[:token])
        else
            user.update(token: auth.credentials[:token])
        end
        user.identities.create(provider: auth.provider, uid: auth.uid)

        user
    end

    def is_admin?
        role == 'admin'
    end

    def with_two_albums?
        albs = albums.pluck(:album_name)
        return false unless albs.include? 'Слинги-рюкзаки'
        return false unless albs.include? 'Май-слинги'
        true
    end

    private

    def create_sites_objects
        Site.create user: self
        VkGroup.create user: self
    end
end
