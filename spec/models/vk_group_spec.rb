RSpec.describe VkGroup, type: :model do
    it { should belong_to :user }
    it { should have_many(:albums).dependent(:destroy) }
    it { should validate_presence_of :user_id }

    it 'should be valid' do
        vk_group = create :vk_group

        expect(vk_group).to be_valid
    end
end
