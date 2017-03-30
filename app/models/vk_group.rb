class VkGroup < ApplicationRecord
    belongs_to :user

    has_many :albums
    accepts_nested_attributes_for :albums, allow_destroy: true

    validates :user_id, presence: true
end
