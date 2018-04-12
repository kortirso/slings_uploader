RSpec.describe Archive, type: :model do
  it { should belong_to :vk_group }
  it { should validate_presence_of :vk_group_id }

  it 'should be valid' do
    archive = create :archive

    expect(archive).to be_valid
  end

  describe 'methods' do
    context '.set?' do
      context 'without album' do
        let!(:archive) { create :archive, :without_album }

        it 'returns false' do
          expect(archive.set?).to eq false
        end
      end

      context 'with album' do
        let!(:archive) { create :archive }

        it 'returns true' do
          expect(archive.set?).to eq true
        end
      end
    end
  end
end
