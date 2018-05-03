require 'rest-client'

module VK
  module Photos
    # photos deleting
    class DeleteService
      def self.call(params)
        res = RestClient.get "https://api.vk.com/method/photos.delete?access_token=#{params[:token]}&owner_id=-#{params[:owner_id]}&photo_id=#{params[:photo_id]}&v=5.63"
        JSON.parse(res.body)
      end
    end
  end
end
