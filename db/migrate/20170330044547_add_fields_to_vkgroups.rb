class AddFieldsToVkgroups < ActiveRecord::Migration[5.0]
    def change
        add_column :vk_groups, :album_id, :integer
        add_index :vk_groups, :album_id
        add_column :vk_groups, :group_id, :string
    end
end
