class SitesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_site

  def update
    @site.update(settings: site_params)
    redirect_to integration_path(current_user)
  end

  private def find_site
    @site = Site.find_by(id: params[:id])
    render_not_found if @site.nil? || @site.user_id != current_user.id
  end

  private def site_params
    params.require(:site).permit!
  end
end
