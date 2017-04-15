class AddDeletingForProducts < ActiveRecord::Migration[5.0]
    def change
        add_column :products, :deleted, :boolean, default: false
    end
end
