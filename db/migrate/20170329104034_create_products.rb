class CreateProducts < ActiveRecord::Migration[5.0]
    def change
        create_table :products do |t|
            t.string :name, null: false, default: ''
            t.string :caption
            t.integer :price, null: false, default: 0
            t.string :slug
            t.integer :category_id
            t.timestamps
        end
        add_index :products, :slug, unique: true
        add_index :products, :category_id
    end
end
