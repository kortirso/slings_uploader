class AddOldIds < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :old_id, :integer
    add_column :vk_groups, :old_id, :integer
    add_column :albums, :old_id, :integer
    add_column :archives, :old_id, :integer
    add_column :products, :old_id, :integer
    add_column :publishes, :old_id, :integer
  end
end
