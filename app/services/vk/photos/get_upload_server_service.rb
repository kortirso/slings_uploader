require 'rest-client'

module VK
  module Photos
    # get upload server for photos
    class GetUploadServerService
      def self.call(params)
        res = RestClient.get "https://api.vk.com/method/photos.getUploadServer?access_token=#{params[:token]}&album_id=#{params[:album_id]}&group_id=#{params[:group_id]}&v=5.63"
        return false unless res.code == 200
        JSON.parse(res.body)
      end
    end
  end
end
