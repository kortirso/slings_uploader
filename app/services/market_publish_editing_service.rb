class MarketPublishEditingService
    CATEGORY_ID = 104

    attr_reader :user, :publish, :upload_url, :upload_hash, :main_photo_id

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
    end

    def editing
        get_upload_url
        upload_image
        save_image
        edit_product_in_market
    end

    private

    def get_upload_url
        response = VK::Photos::GetMarketUploadServerService.call({token: user.token, group_id: user.vk_group.group_id})
        @upload_url = response['response']['upload_url']
    end

    def upload_image
        @upload_hash = VK::Photos::MarketUploadImageService.call({upload_url: upload_url, image_path: publish.product_image.to_s})
    end

    def save_image
        response = VK::Photos::SaveMarketPhotoService.call({token: user.token, group_id: user.vk_group.group_id, caption: publish.caption, server: upload_hash['server'], photo: upload_hash['photo'], hash: upload_hash['hash'], crop_data: upload_hash['crop_data'], crop_hash: upload_hash['crop_hash']})
        @main_photo_id = response['response'][0]['id']
    end

    def edit_product_in_market
        response = VK::Market::EditService.call({token: user.token, owner_id: user.vk_group.group_id, item_id: publish.market_item_id, description: publish.caption, name: publish.name, category_id: CATEGORY_ID, price: publish.price, main_photo_id: main_photo_id})
    end
end