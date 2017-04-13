class AddMarketidToPublish < ActiveRecord::Migration[5.0]
    def change
        add_column :publishes, :market_item_id, :integer
    end
end
