RSpec.describe Publish, type: :model do
  it { should belong_to :user }
  it { should belong_to :product }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :product_id }

  it 'should be valid' do
    publish = create :publish

    expect(publish).to be_valid
  end

  describe 'callbacks' do
    context 'fill_publish' do

    end
  end

  describe 'methods' do
    context '.image_content' do
      let!(:publish) { create :publish }

      it 'returns nil for products without images' do
        expect(publish.image_content).to eq nil
      end

      it 'returns content for products with image' do
        publish.image.attach(io: File.open("#{Rails.root}/spec/test_files/1.jpg"), filename: 'image.jpg')
        publish.reload

        expect(publish.image_content).to_not eq nil
      end
    end

    context '.product_image' do
      let!(:product) { create :product }
      let!(:publish) { create :publish, product: product }

      it 'returns nil if there is no images' do
        expect(publish.product_image).to eq nil
      end

      it 'returns content for product with image' do
        product.image.attach(io: File.open("#{Rails.root}/spec/test_files/1.jpg"), filename: 'image.jpg')
        product.reload

        expect(publish.product_image).to eq product.image_content
        expect(publish.product_image).to_not eq publish.image_content
      end

      it 'returns content for publish with image' do
        publish.image.attach(io: File.open("#{Rails.root}/spec/test_files/1.jpg"), filename: 'image.jpg')
        publish.reload

        expect(publish.product_image).to_not eq product.image_content
        expect(publish.product_image).to eq publish.image_content
      end
    end

    context '.album_of_publish' do
      let!(:user) { create :user }
      let!(:album) { create :album, album_name: 'Базовая коллекция', vk_group: user.vk_group }
      let!(:publish) { create :publish, album_id: album.album_id, user: user }

      it 'returns album object' do
        expect(publish.album_of_publish).to eq album
      end
    end
  end
end
