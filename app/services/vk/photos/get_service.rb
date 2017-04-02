require 'rest-client'

module VK
    module Photos
        class GetService
            def self.call(params)
                res = RestClient.get "https://api.vk.com/method/photos.get?access_token=#{params[:token]}&album_id=#{params[:album_id]}&owner_id=#{params[:group_id]}&count=#{params[:count]}&v=5.63"
                return false unless res.code == 200
                JSON.parse(res.body)
            end
        end
    end
end