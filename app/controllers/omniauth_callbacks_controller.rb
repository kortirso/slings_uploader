class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :get_access
    before_action :provides_callback

    def vkontakte
        
    end

    private

    def provides_callback
        @user = User.find_for_oauth(env['omniauth.auth'])
        if @user
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: "#{action_name}".capitalize) if is_navigational_format?
        else
            redirect_to root_path, flash: { manifesto_username: true }
        end
    end
end