RSpec.describe InstructionsController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      sign_in_user
      before { get :index }

      it 'renders index page' do
        expect(response).to render_template :index
      end
    end

    def do_request
      get :index
    end
  end
end
