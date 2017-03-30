require 'net/http'
require 'net/http/post/multipart'

class PublishService
    attr_reader :user, :product, :upload_url

    def initialize(params)
        @user = params[:user]
        @product = Product.friendly.find(params[:product_name])
    end

    def publish
        get_upload_url
        upload_image
    end

    private

    def get_upload_url
        uri = URI("https://api.vk.com/method/photos.getUploadServer?access_token=#{user.token}&album_id=#{user.vk_group.albums.first.vk_id}&group_id=#{user.vk_group.group_id}&v=5.63")
        req = Net::HTTP::Get.new(uri)
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        return false unless res.code == '200'
        @upload_url = JSON.parse(res.body)['response']['upload_url']
    end

    def upload_image(req = nil)
        uri = URI.parse(upload_url)
        req = Net::HTTP::Post::Multipart.new uri.path, 'file' => UploadIO.new(File.new("#{Rails.root}/public#{product.image.to_s}"), 'image/jpeg', "#{product.image.to_s.split('/').last}")
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
        res.body
    end
end