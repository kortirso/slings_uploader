require 'rest-client'

module VK
  module Market
    # Delete product from market
    class DeleteService
      def self.call(params)
        res = RestClient.get "https://api.vk.com/method/market.delete?access_token=#{params[:token]}&owner_id=-#{params[:owner_id]}&item_id=#{params[:item_id]}&v=5.63"
        JSON.parse(res.body)
      end
    end
  end
end
