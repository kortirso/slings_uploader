class RemoveColumnFromVkgroup < ActiveRecord::Migration[5.0]
    def change
        remove_column :vk_groups, :album_id
    end
end
