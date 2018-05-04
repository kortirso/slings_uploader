class AddOldIdsCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :old_id, :integer
  end
end
