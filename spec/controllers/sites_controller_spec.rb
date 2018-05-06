RSpec.describe SitesController, type: :controller do
  describe 'PATCH #update' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      sign_in_admin
      let(:request) { patch :update, params: { id: @current_user.site.id, site: { request_for_loading: '123' } } }

      it 'updates sites settings' do
        old_site = @current_user.site
        request
        @current_user.site.reload

        expect(@current_user.site).to eq old_site
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
