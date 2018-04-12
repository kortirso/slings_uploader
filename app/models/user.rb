class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:vkontakte]

  has_many :identities, dependent: :destroy
  has_many :publishes, dependent: :destroy
  
  has_one :site, dependent: :destroy
  has_one :vk_group, dependent: :destroy
  has_many :albums, through: :vk_group

  validates :role, presence: true, inclusion: { in: %w[user admin] }

  after_create :create_sites_objects

  def self.find_for_oauth(auth)
    identity = Identity.find_for_oauth(auth)
    return identity.user if identity.present?
    email = auth.info[:email].empty? ? "#{auth.info[:name].downcase.split(' ').join('_')}@app.ru" : auth.info[:email]
    user = User.find_or_create_by(email: email) do |u|
      u.password = Devise.friendly_token[0, 20]
    end
    user.identities.create(provider: auth.provider, uid: auth.uid)
    user
  end

  def admin?
    role == 'admin'
  end

  def with_albums?
    albs = albums.pluck(:album_name)
    return false unless albs.include? 'Базовая коллекция'
    return false unless albs.include? 'Коллекция Весна-Лето'
    return false unless albs.include? 'Коллекция Остатки сладки'
    true
  end

  def with_valid_token?
    self.updated_at + 1.day < Time.now
  end

  private def create_sites_objects
    Site.create user: self
    VkGroup.create user: self
  end
end
