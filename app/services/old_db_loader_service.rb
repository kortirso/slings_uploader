# save old db
class OldDbLoaderService
  def load
    categories_loading
    user_loading
    groups_loading
    albums_loading
    archives_loading
    products_loading
    publishes_loading
    attachments_loading
  end

  private def categories_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/categories.json"))).each do |category|
      Category.create(name: category['name'], slug: category['slug'], old_id: category['id'])
    end
  end

  private def user_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/users.json"))).each do |user|
      User.create(email: user['email'], password: Devise.friendly_token[0, 20], role: user['role'], old_id: user['id'])
    end
  end

  private def groups_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/vk_groups.json"))).each do |group|
      user = User.find_by(old_id: group['user_id'])
      user.vk_group.update(identifier: group['group_id'], old_id: group['id'])
    end
  end

  private def albums_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/albums.json"))).each do |album|
      group = VkGroup.find_by(old_id: album['vk_group_id'])
      group.albums.create(name: album['album_name'], identifier: album['album_id'])
    end
  end

  private def archives_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/archives.json"))).each do |archive|
      group = VkGroup.find_by(old_id: archive['vk_group_id'])
      Archive.create(vk_group: group, identifier: archive['album_id'])
    end
  end

  private def products_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/products.json"))).each do |product|
      category = Category.find_by(old_id: product['category_id'])
      category.products.create(name: product['name'], caption: product['caption'], price: product['price'], slug: product['slug'], deleted: product['deleted'], old_id: product['id'])
    end
  end

  private def publishes_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/publishes.json"))).each do |publish|
      user = User.find_by(old_id: publish['user_id'])
      product = Product.find_by(old_id: publish['product_id'])
      Publish.create(name: publish['name'], caption: publish['caption'], price: publish['price'], user: user, product: product, vk_item: publish['album_id'], market_item: publish['market_item_id'], site_item: publish['site_item_id'], published: publish['published'], old_id: publish['id'])
    end
  end

  private def attachments_loading
    JSON.parse(JSON.parse(File.read("#{Rails.root}/db/old_db/attachments_published.json"))).each do |attachment|
      publish = Publish.find_by(old_id: attachment['publish_id'])
      publish.update(vk_photo_identifier: attachment['photo_id']) if publish.present?
    end
  end
end