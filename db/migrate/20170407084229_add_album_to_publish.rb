class AddAlbumToPublish < ActiveRecord::Migration[5.0]
    def change
        add_column :publishes, :album_id, :integer
        add_index :publishes, :album_id
    end
end
