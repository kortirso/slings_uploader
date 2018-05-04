RSpec.describe Publish, type: :model do
  it { should belong_to :user }
  it { should belong_to :product }
  it { should validate_presence_of :user }
  it { should validate_presence_of :product }

  it 'should be valid' do
    publish = create :publish

    expect(publish).to be_valid
  end

  describe 'callbacks' do
    context 'fill_publish' do
    end
  end

  describe 'methods' do
    context '.album_of_publish' do
      let!(:user) { create :user }
      let!(:album) { create :album, name: 'Базовая коллекция', vk_group: user.vk_group }
      let!(:publish) { create :publish, vk_item: album.identifier, user: user }

      it 'returns album object' do
        expect(publish.album_of_publish).to eq album
      end
    end
  end
end
