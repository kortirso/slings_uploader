require 'net/http'

module VK
  module Photos
    # save service
    class SaveService
      def self.call(params)
        uri = URI("https://api.vk.com/method/photos.save?access_token=#{params[:token]}&album_id=#{params[:album_id]}&group_id=#{params[:group_id]}&server=#{params[:server]}&photos_list=#{params[:photos_list]}&hash=#{params[:hash]}&v=5.63")
        req = Net::HTTP::Post.new(uri)
        req.set_form_data(caption: params[:caption])
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        JSON.parse(res.body)
      end
    end
  end
end
