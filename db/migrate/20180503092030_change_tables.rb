class ChangeTables < ActiveRecord::Migration[5.2]
  def change
    rename_column :albums, :album_id, :identifier
    rename_column :albums, :album_name, :name

    rename_column :archives, :album_id, :identifier

    remove_column :publishes, :album_id
    add_column :publishes, :vk_item, :integer
    rename_column :publishes, :market_item_id, :market_item
    rename_column :publishes, :site_item_id, :site_item

    rename_column :vk_groups, :group_id, :identifier
  end
end
