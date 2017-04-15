class RebuildTablesForAttachments < ActiveRecord::Migration[5.0]
    def change
        remove_column :publishes, :image
        remove_column :publishes, :photo_id
        add_column :attachments, :photo_id, :string
    end
end
