class CreateAlbums < ActiveRecord::Migration[5.0]
    def change
        create_table :albums do |t|
            t.integer :vk_id
            t.integer :vk_group_id
            t.timestamps
        end
        add_index :albums, :vk_group_id
    end
end
