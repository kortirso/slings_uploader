class AddSitesidToPublishes < ActiveRecord::Migration[5.0]
    def change
        add_column :publishes, :site_item_id, :integer, default: nil
    end
end
