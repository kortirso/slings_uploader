class Album < ApplicationRecord
  belongs_to :vk_group

  has_many :publishes

  validates :vk_group_id, :album_id, presence: true

  def self.get_list
    all.collect { |album| [album.album_name, album.album_id] }
  end
end
