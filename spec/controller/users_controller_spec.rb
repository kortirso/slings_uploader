RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it_behaves_like 'authorization'

    context 'for user' do
      sign_in_user

      it 'should render index view' do
        get :index

        expect(response).to render_template :index
      end
    end

    def do_request
      get :index
    end
  end
end
