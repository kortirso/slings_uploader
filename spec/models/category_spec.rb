RSpec.describe Category, type: :model do
    it { should have_many(:products).dependent(:destroy) }
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }

    it 'should be valid' do
        category = create :category

        expect(category).to be_valid
    end

    describe 'methods' do
        context '.get_list' do
            let!(:category) { create :category }

            it 'should return double array with category name and id' do
                expect(Category.get_list).to eq [[category.name, category.id]]
            end
        end
    end
end
