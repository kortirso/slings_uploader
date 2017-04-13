require 'rest-client'

module VK
    module Photos
        class GetMarketUploadServerService
            def self.call(params)
                res = RestClient.get "https://api.vk.com/method/photos.getMarketUploadServer?access_token=#{params[:token]}&main_photo=1&group_id=#{params[:group_id]}&v=5.63"
                return false unless res.code == 200
                JSON.parse(res.body)
            end
        end
    end
end