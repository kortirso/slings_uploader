class AddPublishToAttachments < ActiveRecord::Migration[5.0]
    def change
        add_column :attachments, :publish_id, :integer
        add_index :attachments, :publish_id
    end
end
