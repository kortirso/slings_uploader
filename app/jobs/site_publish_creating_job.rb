class SitePublishCreatingJob < ApplicationJob
    queue_as :default

    def perform(params)
        SitePublishCreatingService.new({user: params[:user], publish: params[:publish]}).publishing
    end
end
