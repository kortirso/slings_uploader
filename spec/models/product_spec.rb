RSpec.describe Product, type: :model do
    it { should belong_to :category }
    it { should have_many :publishes }
    it { should validate_presence_of :name }
    it { should validate_presence_of :category_id }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }

    it 'should be valid' do
        product = create :product

        expect(product).to be_valid
    end
end
