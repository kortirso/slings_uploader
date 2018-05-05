require 'rest-client'

module VK
  module Photos
    # upload image
    class UploadImageService
      def self.call(args = {})
        filename = "#{Rails.root}/tmp/#{args[:temp_name]}"
        File.open(filename, 'wb') { |f| f.write(args[:image_content]) }
        res = RestClient.post(args[:upload_url], file1: File.open(filename))
        File.delete(filename)
        return false unless res.code == 200
        JSON.parse(res.body)
      end
    end
  end
end
