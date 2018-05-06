class SitesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :select_site

  def update
    @site.update(settings: site_params)
    redirect_to integration_path(current_user)
  end

  private def select_site
    @site = current_user.site
  end

  private def site_params
    params.require(:site).permit!
  end
end
