RSpec.describe Product, type: :model do
  it { should belong_to :category }
  it { should have_many :publishes }
  it { should validate_presence_of :name }
  it { should validate_presence_of :category }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }

  it 'should be valid' do
    product = create :product

    expect(product).to be_valid
  end

  describe 'methods' do
    context '.delete' do
      let!(:product) { create :product }

      it 'updates deleted field for product' do
        product.delete
        product.reload

        expect(product.deleted).to eq true
      end
    end

    context '.status' do
      let!(:product) { create :product }

      it 'returns Новый' do
        expect(product.status).to eq 'Новый'
      end

      it 'returns Удален' do
        product.delete
        product.reload

        expect(product.status).to eq 'Удален'
      end

      it 'returns Обновлен' do
        product.update(price: '123')
        product.reload

        expect(product.status).to eq 'Обновлен'
      end
    end

    context 'publishing' do
      let!(:user) { create :user }
      let!(:category) { create :category, name: 'Базовая коллекция' }
      let!(:products) { create_list(:product, 2, category: category) }
      let!(:publish) { create :publish, product: products.first, user: user, published: true }

      context '.published' do
        it 'returns 1 published product' do
          result = Product.published(user)

          expect(result.is_a?(Array)).to eq true
          expect(result.size).to eq 1
          expect(result[0]).to eq publish.product
        end
      end

      context '.unpublished' do
        it 'returns 1 unpublished product' do
          result = Product.unpublished(user)

          expect(result.is_a?(Array)).to eq true
          expect(result.size).to eq 1
          expect(result[0]).to eq products.last
        end
      end

      context '.create_publishes' do
        let!(:album) { create :album, name: 'Базовая коллекция', vk_group: user.vk_group }

        it 'creates new publish for product' do
          expect { Product.create_publishes(user) }.to change { products.last.publishes.count }.by(1)
        end

        it 'and returns new published products' do
          result = Product.create_publishes(user)

          expect(result.is_a?(Array)).to eq true
          expect(result.size).to eq 1
          expect(result[0].is_a?(Publish)).to eq true
        end
      end
    end
  end
end
