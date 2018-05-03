RSpec.describe Album, type: :model do
  it { should belong_to :vk_group }
  it { should validate_presence_of :vk_group_id }
  it { should validate_presence_of :identifier }

  it 'should be valid' do
    album = create :album

    expect(album).to be_valid
  end

  describe 'methods' do
    context '.list' do
      let!(:album) { create :album }

      it 'should return double array with album name and id' do
        expect(Album.list).to eq [[album.name, album.identifier]]
      end
    end
  end
end
