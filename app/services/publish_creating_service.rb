class PublishCreatingService
    attr_reader :user, :publish, :upload_url, :upload_hash, :photo_id

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
    end

    def publishing
        get_upload_url
        upload_image
        save_image
        update_publish
    end

    private

    def get_upload_url
        response = VK::Photos::GetUploadServerService.call({token: user.token, album_id: publish.album_id, group_id: user.vk_group.group_id})
        @upload_url = response['response']['upload_url']
    end

    def upload_image
        @upload_hash = VK::Photos::UploadImageService.call({upload_url: upload_url, image_path: publish.product_image.to_s})
    end

    def save_image
        response = VK::Photos::SaveService.call({token: user.token, album_id: publish.album_id, group_id: user.vk_group.group_id, caption: publish.caption, server: upload_hash['server'], photos_list: upload_hash['photos_list'], hash: upload_hash['hash']})
        @photo_id = response['response'][0]['id']
    end

    def update_publish
        publish.update(photo_id: photo_id)
    end
end