require 'net/http'

module VK
    module Market
        class EditService
            def self.call(params)
                uri = URI("https://api.vk.com/method/market.edit?access_token=#{params[:token]}&owner_id=-#{params[:owner_id]}&item_id=#{params[:item_id]}&category_id=#{params[:category_id]}&price=#{params[:price]}&main_photo_id=#{params[:main_photo_id]}&v=5.63")
                req = Net::HTTP::Post.new(uri)
                req.set_form_data(name: params[:name], description: params[:description])
                res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
                JSON.parse(res.body)
            end
        end
    end
end