require 'rest-client'
require 'net/http'

class PublishService
    attr_reader :user, :product, :upload_url, :upload_hash

    def initialize(params)
        @user = params[:user]
        @product = Product.friendly.find(params[:product_name])
    end

    def publish
        get_upload_url
        upload_image
        saving_image
    end

    private

    def get_upload_url
        res = RestClient.get "https://api.vk.com/method/photos.getUploadServer?access_token=#{user.token}&album_id=#{user.vk_group.albums.first.vk_id}&group_id=#{user.vk_group.group_id}&v=5.63"
        return false unless res.code == 200
        @upload_url = JSON.parse(res.body)['response']['upload_url']
    end

    def upload_image
        res = RestClient.post upload_url, file1: File.new("#{Rails.root}/public#{product.image.to_s}")
        return false unless res.code == 200
        @upload_hash = JSON.parse(res.body)
    end

    def saving_image
        uri = URI("https://api.vk.com/method/photos.save?access_token=#{user.token}&album_id=#{user.vk_group.albums.first.vk_id}&group_id=#{user.vk_group.group_id}&server=#{upload_hash['server']}&photos_list=#{upload_hash['photos_list']}&hash=#{upload_hash['hash']}&v=5.63")
        req = Net::HTTP::Post.new(uri)
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    end
end