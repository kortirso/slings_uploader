class ApplicationController < ActionController::Base
  prepend_view_path Rails.root.join('frontend')

  protect_from_forgery with: :exception

  before_action :get_access

  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def catch_404
    raise ActionController::RoutingError.new(params[:path]), 'route error'
  end

  private def get_access
    render template: 'welcome/index', layout: 'welcome' unless user_signed_in?
  end

  private def check_admin_role
    render template: 'shared/404', status: 404 unless current_user.admin?
  end

  private def get_categories
    @categories = Category.all
  end

  private def render_not_found
    render template: 'shared/404', status: 404
  end
end
