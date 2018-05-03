require 'net/http'

# Publishing to sites
class SitePublishCreatingService
  attr_reader :user, :publish, :album_id

  def initialize(params)
    @user = params[:user]
    @publish = params[:publish]
    @album_id = params[:album_id]
  end

  def create
    uri = URI(generate_uri)
    req = Net::HTTP::Post.new(uri)
    req.set_form_data(name: publish.name, caption: publish.caption, price: publish.price, category_name: user.albums.find_by(album_id: album_id).album_name, image: "#{ENV['APP_HOST']}#{publish.product_image}")
    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
    answer = JSON.parse(res.body)
    publish.update(site_item_id: answer['product']['id']) if answer['product'].present?
  rescue
    false
  end

  def update
    uri = URI(generate_uri(true))
    req = Net::HTTP::Put.new(uri)
    req.set_form_data(name: publish.name, caption: publish.caption, price: publish.price, category_name: user.albums.find_by(album_id: album_id).album_name, site_item_id: publish.site_item_id, image: "#{ENV['APP_HOST']}#{publish.product_image}")
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
  rescue
    false
  end

  def destroy
    uri = URI(generate_uri(true))
    req = Net::HTTP::Delete.new(uri)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
  rescue
    false
  end

  private def generate_uri(with_id = false)
    uri = user.site.settings['request_for_loading']
    uri += "#{('/' + publish.site_item_id.to_s) if with_id}?#{user.site.settings['key_name']}=#{user.site.settings['key_value']}" if user.site.settings['need_key']
    uri
  end
end
