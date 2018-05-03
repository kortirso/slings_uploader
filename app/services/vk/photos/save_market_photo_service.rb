require 'net/http'

module VK
  module Photos
    # save photo to market
    class SaveMarketPhotoService
      def self.call(params)
        uri = URI("https://api.vk.com/method/photos.saveMarketPhoto?access_token=#{params[:token]}&group_id=#{params[:group_id]}&server=#{params[:server]}&photo=#{params[:photo]}&hash=#{params[:hash]}&crop_data=#{params[:crop_data]}&crop_hash=#{params[:crop_hash]}&v=5.63")
        req = Net::HTTP::Post.new(uri)
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        JSON.parse(res.body)
      end
    end
  end
end
