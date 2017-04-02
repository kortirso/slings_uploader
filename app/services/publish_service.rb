class PublishService
    attr_reader :user, :product

    def initialize(params)
        @user = params[:user]
        @product = Product.friendly.find(params[:product_name])
    end

    def publish
        upload_url = VK::Photos::GetUploadServerService.call({token: user.token, album_id: user.vk_group.albums.first.vk_id, group_id: user.vk_group.group_id})
        upload_hash = VK::Photos::UploadImageService.call({upload_url: upload_url, image_path: product.image.to_s})
        VK::Photos::SaveService.call({token: user.token, album_id: user.vk_group.albums.first.vk_id, group_id: user.vk_group.group_id, server: upload_hash['server'], photos_list: upload_hash['photos_list'], hash: upload_hash['hash']})
    end
end