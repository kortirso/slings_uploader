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
        context '.product_image' do

        end
    end
end
