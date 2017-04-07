class Album < ApplicationRecord
    belongs_to :vk_group

    validates :vk_group_id, :album_id, presence: true
end
