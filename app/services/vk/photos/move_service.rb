require 'rest-client'

module VK
  module Photos
    # move service
    class MoveService
      def self.call(params)
        res = RestClient.get "https://api.vk.com/method/photos.move?access_token=#{params[:token]}&owner_id=-#{params[:owner_id]}&target_album_id=#{params[:target_album_id]}&photo_id=#{params[:photo_id]}&v=5.63"
        JSON.parse(res.body)
      end
    end
  end
end
