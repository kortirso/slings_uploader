RSpec.describe MarketPublishCreateService do
  let!(:user) { create :user, token: '' }
  let!(:publish) { create :publish, user: user }
  let!(:creator) { MarketPublishCreateService.new(user: user, publish: publish) }

  describe '.initialize' do
    it 'assigns user to @user' do
      expect(creator.user).to eq user
    end

    it 'and assigns publish to @publish' do
      expect(creator.publish).to eq publish
    end

    it 'and assigns VkApiSimple::Photos to @client' do
      expect(creator.client.is_a?(VkApiSimple::Photos)).to eq true
    end

    it 'and assigns VkApiSimple::Market to @market_client' do
      expect(creator.market_client.is_a?(VkApiSimple::Market)).to eq true
    end
  end
end
