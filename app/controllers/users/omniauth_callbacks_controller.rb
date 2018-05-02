module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :check_access
    before_action :provides_callback

    def vkontakte; end

    private def provides_callback
      return redirect_to root_path, flash: { error: 'Ошибка доступа ВК, зайдите позже' } if request.env['omniauth.auth'].nil?
      @user = User.find_for_oauth(request.env['omniauth.auth'])
      if @user
        @user.update(token: request.env['omniauth.auth'].credentials[:token])
        sign_in @user
        redirect_to root_path, event: :authentication
      else
        redirect_to root_path, flash: { manifesto_username: true }
      end
    end
  end
end
