class CreateAttachments < ActiveRecord::Migration[5.0]
    def change
        create_table :attachments do |t|
            t.string :image
            t.integer :product_id
            t.timestamps
        end
        add_index :attachments, :product_id
        remove_column :products, :image
        remove_column :products, :images
    end
end
