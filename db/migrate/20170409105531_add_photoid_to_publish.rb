class AddPhotoidToPublish < ActiveRecord::Migration[5.0]
    def change
        add_column :publishes, :photo_id, :integer
    end
end
