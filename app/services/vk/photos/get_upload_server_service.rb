require 'rest-client'

module VK
  module Photos
    # get upload server for photos
    class GetUploadServerService
      def self.call(args = {})
        res = RestClient.get("https://api.vk.com/method/photos.getUploadServer?access_token=#{args[:token]}&album_id=#{args[:album_id]}&group_id=#{args[:group_id]}&v=5.63")
        return false unless res.code == 200
        JSON.parse(res.body)
      end
    end
  end
end
