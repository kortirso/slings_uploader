class CreateVkGroups < ActiveRecord::Migration[5.0]
    def change
        create_table :vk_groups do |t|
            t.integer :user_id
            t.timestamps
        end
        add_index :vk_groups, :user_id
    end
end
