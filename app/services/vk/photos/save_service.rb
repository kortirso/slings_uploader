require 'net/http'

module VK
    module Photos
        class SaveService
            def self.call(params)
                uri = URI("https://api.vk.com/method/photos.save?access_token=#{params[:token]}&album_id=#{params[:album_id]}&group_id=#{params[:group_id]}&server=#{params[:server]}&photos_list=#{params[:photos_list]}&hash=#{params[:hash]}&v=5.63")
                req = Net::HTTP::Post.new(uri)
                Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
            end
        end
    end
end