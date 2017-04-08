RSpec.describe Album, type: :model do
    it { should belong_to :vk_group }
    it { should have_many :publishes }
    it { should validate_presence_of :vk_group_id }
    it { should validate_presence_of :album_id }

    it 'should be valid' do
        album = create :album

        expect(album).to be_valid
    end

    describe 'methods' do
        context '.get_list' do
            let!(:album) { create :album }

            it 'should return double array with album name and id' do
                expect(Album.get_list).to eq [[album.album_name, album.album_id]]
            end
        end
    end
end
