RSpec.describe MarketPublishesCreateJob, type: :job do
  let!(:user) { create :user }
  let!(:album1) { create :album, name: 'Базовая коллекция', vk_group: user.vk_group }
  let!(:album2) { create :album, name: 'Коллекция Весна-Лето', vk_group: user.vk_group }
  let!(:album3) { create :album, name: 'Коллекция Остатки сладки', vk_group: user.vk_group }
  let!(:category) { create :category, name: 'Базовая коллекция' }
  let!(:product) { create :product, category: category }
  let!(:publish) { create :publish, product: product, user: user }

  it 'executes method publish of MarketPublishCreateService' do
    expect_any_instance_of(MarketPublishCreateService).to receive(:publishing)

    MarketPublishesCreateJob.perform_now(user: user)
  end
end
