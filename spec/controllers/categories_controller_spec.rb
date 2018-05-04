RSpec.describe CategoriesController, type: :controller do
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

  describe 'GET #show' do
    it_behaves_like 'Check access'

    context 'for logged user' do
      sign_in_user

      context 'if category does not exist' do
        before { get :show, params: { id: 999 } }

        it 'renders show page' do
          expect(response).to render_template 'shared/404'
        end
      end

      context 'if category exists' do
        let!(:category) { create :category }
        before { get :show, params: { id: category.id } }

        it 'renders show page' do
          expect(response).to render_template :show
        end
      end
    end

    def do_request
      get :show, params: { id: 999 }
    end
  end
end
