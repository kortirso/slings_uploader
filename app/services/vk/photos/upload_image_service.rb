require 'rest-client'

module VK
  module Photos
    # upload image
    class UploadImageService
      def self.call(params)
        res = RestClient.post params[:upload_url], file1: File.new("#{Rails.root}/public#{params[:image_path]}")
        return false unless res.code == 200
        JSON.parse(res.body)
      end
    end
  end
end
