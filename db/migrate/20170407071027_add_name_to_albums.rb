class AddNameToAlbums < ActiveRecord::Migration[5.0]
    def change
        rename_column :albums, :vk_id, :album_id
        add_column :albums, :album_name, :string, nill: false, default: ''
    end
end
