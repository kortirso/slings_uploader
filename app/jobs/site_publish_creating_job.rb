class SitePublishCreatingJob < ApplicationJob
    queue_as :default

    def perform(params)
        if params[:publish].site_item_id.nil?
            SitePublishCreatingService.new({user: params[:user], publish: params[:publish]}).create
        else
            SitePublishCreatingService.new({user: params[:user], publish: params[:publish]}).update
        end
    end
end
