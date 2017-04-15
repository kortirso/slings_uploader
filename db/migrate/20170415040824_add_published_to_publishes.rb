class AddPublishedToPublishes < ActiveRecord::Migration[5.0]
    def change
        add_column :publishes, :published, :boolean, default: false
    end
end
