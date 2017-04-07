class AddNameToPublish < ActiveRecord::Migration[5.0]
    def change
        add_column :publishes, :name, :string, null: false, default: ''
        change_column :products, :caption, :text
    end
end
