RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    context 'for logged user' do
      sign_in_user

      let(:request) { get :index }

      it 'renders index page' do
        request

        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    context 'for logged user' do
      sign_in_user
      let!(:category) { create :category }
      let(:request) { get :show, params: { id: category.id } }

      it 'renders show page' do
        request

        expect(response).to render_template :show
      end
    end
  end
end
