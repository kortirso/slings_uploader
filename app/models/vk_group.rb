class VkGroup < ApplicationRecord
  belongs_to :user

  has_many :albums, dependent: :destroy
  accepts_nested_attributes_for :albums, allow_destroy: true
  has_one :archive, dependent: :destroy
  accepts_nested_attributes_for :archive, allow_destroy: true

  validates :user_id, presence: true
end
