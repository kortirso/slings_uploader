class CreateSites < ActiveRecord::Migration[5.0]
    def change
        create_table :sites do |t|
            t.integer :user_id
            t.timestamps
        end
        add_index :sites, :user_id
    end
end
