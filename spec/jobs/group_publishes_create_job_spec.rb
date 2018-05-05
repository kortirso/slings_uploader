RSpec.describe GroupPublishesCreateJob, type: :job do
  let!(:user) { create :user }
  let!(:album1) { create :album, name: 'Базовая коллекция', vk_group: @current_user.vk_group }
  let!(:album2) { create :album, name: 'Коллекция Весна-Лето', vk_group: @current_user.vk_group }
  let!(:album3) { create :album, name: 'Коллекция Остатки сладки', vk_group: @current_user.vk_group }
  let!(:product) { create :product }

  it 'executes method call of TaskProcessingService' do
    expect_any_instance_of(GroupPublishCreateService).to receive(:publish)

    GroupPublishesCreateJob.perform_now(user: user)
  end

  context '.publishes' do
    it 'calls create_publishes for Product' do
      expect(Product).to receive(:create_publishes)

      GroupPublishesCreateJob.new.send(:publishes, user)
    end
  end
end
