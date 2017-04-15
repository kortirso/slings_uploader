class AddParentToAttachment < ActiveRecord::Migration[5.0]
    def change
        add_column :attachments, :parent_id, :integer
    end
end
