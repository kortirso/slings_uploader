require 'net/http'

class SitePublishCreatingService
    attr_reader :user, :publish

    def initialize(params)
        @user = params[:user]
        @publish = params[:publish]
    end

    def publishing
        begin
            uri = URI(generate_uri)
            req = Net::HTTP::Post.new(uri)
            req.set_form_data(name: publish.name, caption: publish.caption, price: publish.price, category_name: publish.product.category.name)
            Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
        rescue
            false
        end
    end

    private

    def generate_uri
        uri = user.site.settings['request_for_loading']
        uri += "?#{user.site.settings['key_name']}=#{user.site.settings['key_value']}" if user.site.settings['need_key']
    end
end