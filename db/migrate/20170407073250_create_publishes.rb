class CreatePublishes < ActiveRecord::Migration[5.0]
    def change
        create_table :publishes do |t|
            t.text :caption
            t.integer :price
            t.string :image
            t.integer :user_id
            t.integer :product_id
            t.timestamps
        end
        add_index :publishes, :user_id
        add_index :publishes, :product_id
    end
end
