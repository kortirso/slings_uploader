# Represents albums for photos
class Album < ApplicationRecord
  belongs_to :vk_group

  validates :vk_group, :identifier, presence: true

  def self.list
    all.collect { |album| [album.name, album.identifier] }
  end
end
