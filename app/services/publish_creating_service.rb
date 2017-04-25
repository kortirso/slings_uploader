class PublishCreatingService
    attr_reader :user, :publish, :photos_check, :photos_list, :upload_url, :upload_hash

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
        @photos_check = params[:photos_check]
        @photos_list = []
    end

    def publishing
        get_photos_list
        photos_list.each do |photo|
            get_upload_url
            upload_image(photo)
            next if upload_hash['error'].present?
            save_image(photo)
        end
        update_publish
    end

    private

    def get_photos_list
        if photos_check.nil?
            photos_list.push publish.product.attachments.first
        else
            publish.product.attachments.each { |a| photos_list.push a }
        end
    end

    def get_upload_url
        response = VK::Photos::GetUploadServerService.call({token: user.token, album_id: publish.album_id, group_id: user.vk_group.group_id})
        @upload_url = response['response']['upload_url']
    end

    def upload_image(photo)
        @upload_hash = VK::Photos::UploadImageService.call({upload_url: upload_url, image_path: photo.image.to_s})
    end

    def save_image(photo)
        response = VK::Photos::SaveService.call({token: user.token, album_id: publish.album_id, group_id: user.vk_group.group_id, caption: publish.caption, server: upload_hash['server'], photos_list: upload_hash['photos_list'], hash: upload_hash['hash']})
        publish.attachments.create photo_id: response['response'][0]['id'], parent: photo
    end

    def update_publish
        publish.update(published: true)
    end
end