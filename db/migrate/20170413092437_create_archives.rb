class CreateArchives < ActiveRecord::Migration[5.0]
    def change
        create_table :archives do |t|
            t.integer :vk_group_id
            t.integer :album_id
            t.timestamps
        end
        add_index :archives, :vk_group_id
    end
end
