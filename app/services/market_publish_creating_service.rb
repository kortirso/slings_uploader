class MarketPublishCreatingService
    CATEGORY_ID = 104

    attr_reader :user, :publish, :auto, :upload_url, :upload_hash, :main_photo_id, :market_item_id

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
        @auto = params[:auto]
    end

    def publishing
        get_upload_url
        upload_image
        return false if upload_hash['error'].present?
        save_image
        add_product_to_market
        update_publish
    end

    private

    def get_upload_url
        response = VK::Photos::GetMarketUploadServerService.call({token: user.token, group_id: user.vk_group.group_id})
        @upload_url = response['response']['upload_url']
    end

    def upload_image
        @upload_hash = VK::Photos::MarketUploadImageService.call({upload_url: upload_url, image_path: publish.product_image})
    end

    def save_image
        response = VK::Photos::SaveMarketPhotoService.call({token: user.token, group_id: user.vk_group.group_id, caption: publish.caption, server: upload_hash['server'], photo: upload_hash['photo'], hash: upload_hash['hash'], crop_data: upload_hash['crop_data'], crop_hash: upload_hash['crop_hash']})
        @main_photo_id = response['response'][0]['id']
    end

    def add_product_to_market
        response = VK::Market::AddService.call({token: user.token, owner_id: user.vk_group.group_id, description: publish.caption, name: name_for_publish, category_id: CATEGORY_ID, price: publish.price, main_photo_id: main_photo_id})
        @market_item_id = response['response']['market_item_id']
    end

    def name_for_publish
        auto.nil? ? publish.name : "#{publish.product.category.single_name} #{publish.name}"
    end

    def update_publish
        publish.update(market_item_id: market_item_id)
    end
end