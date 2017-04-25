class AddParamsToSite < ActiveRecord::Migration[5.0]
    def change
        add_column :sites, :settings, :json, default: {}
    end
end
