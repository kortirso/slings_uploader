RSpec.describe Site, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :user_id }

  it 'should be valid' do
    site = create :site

    expect(site).to be_valid
  end
end
