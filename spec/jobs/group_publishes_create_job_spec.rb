RSpec.describe GroupPublishesCreateJob, type: :job do
  let!(:user) { create :user }
  let!(:album1) { create :album, name: 'Базовая коллекция', vk_group: user.vk_group }
  let!(:album2) { create :album, name: 'Коллекция Весна-Лето', vk_group: user.vk_group }
  let!(:album3) { create :album, name: 'Коллекция Остатки сладки', vk_group: user.vk_group }
  let!(:category) { create :category, name: 'Базовая коллекция' }
  let!(:product) { create :product, category: category }

  it 'executes method publish of GroupPublishCreateService' do
    expect_any_instance_of(GroupPublishCreateService).to receive(:publishing)

    GroupPublishesCreateJob.perform_now(user: user)
  end

  context '.publishes' do
    it 'calls create_publishes for Product' do
      expect(Product).to receive(:create_publishes)

      GroupPublishesCreateJob.new.send(:publishes, user)
    end

    it 'and returns array of publishes' do
      result = GroupPublishesCreateJob.new.send(:publishes, user)

      expect(result.is_a?(Array)).to eq true
      expect(result[0].is_a?(Publish)).to eq true
    end
  end
end
