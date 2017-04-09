class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :get_access

    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def catch_404
        raise ActionController::RoutingError.new(params[:path])
    end

    private

    def get_access
        render template: 'welcome/index' unless user_signed_in?
    end

    def check_admin_role
        render template: 'shared/404', status: 404 unless current_user.is_admin?
    end

    def get_categories
        @categories = Category.all
    end

    def render_not_found
        render template: 'shared/404', status: 404
    end
end
