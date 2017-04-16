class AddSingleToCategories < ActiveRecord::Migration[5.0]
    def change
        add_column :categories, :single_name, :string, default: ''
    end
end
