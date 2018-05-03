RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  it { should use_before_action :provides_callback }

  describe 'vkontakte' do
    context 'without info from provider' do
      before :each do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = nil
      end
      before { get 'vkontakte' }

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'and sets flash message with error' do
        expect(request.flash[:error]).to eq 'Ошибка доступа ВК, зайдите позже'
      end
    end

    context 'with info from provider' do
      before :each do
        request.env['devise.mapping'] = Devise.mappings[:user]
        request.env['omniauth.auth'] = vkontakte_hash
      end

      it 'redirects to user path' do
        get 'vkontakte'

        expect(response).to redirect_to root_path
      end
    end
  end
end
