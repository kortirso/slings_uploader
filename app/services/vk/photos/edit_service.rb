require 'net/http'

module VK
  module Photos
    # photos edit service
    class EditService
      def self.call(params)
        uri = URI("https://api.vk.com/method/photos.edit?access_token=#{params[:token]}&owner_id=-#{params[:owner_id]}&photo_id=#{params[:photo_id]}&v=5.63")
        req = Net::HTTP::Post.new(uri)
        req.set_form_data(caption: params[:caption])
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        JSON.parse(res.body)
      end
    end
  end
end
