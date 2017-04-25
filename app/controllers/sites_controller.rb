class SitesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :update
    before_action :find_site

    def update
        #@site.update(site_params)
        #redirect_to current_user
    end

    private

    def find_site
        @site = Site.find(params[:id])
        render_not_found if @site.user_id != current_user.id
    end

    def site_params
        params.require(:site).permit!
    end
end