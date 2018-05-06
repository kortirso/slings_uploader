RSpec.describe VkGroupsController, type: :controller do
  describe 'PATCH #update' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      sign_in_user
      let(:request) { patch :update, params: { id: @current_user.vk_group.id, vk_group: { identifier: '000', albums_attributes: { '0' => { 'name' => 'Базовая коллекция', 'identifier' => '116318831' } } } } }

      it 'updates sites settings' do
        old_site = @current_user.vk_group
        request
        @current_user.vk_group.reload

        expect(@current_user.vk_group).to eq old_site
      end

      it 'redirect_to integration page' do
        request

        expect(response).to redirect_to integration_path(@current_user)
      end
    end

    def do_request
      patch :update, params: { id: 999, product: {} }
    end
  end
end
