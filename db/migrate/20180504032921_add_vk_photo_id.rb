class AddVkPhotoId < ActiveRecord::Migration[5.2]
  def change
    add_column :publishes, :vk_photo_identifier, :string
  end
end
