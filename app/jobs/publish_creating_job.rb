class PublishCreatingJob < ApplicationJob
    queue_as :default

    def perform(params)
        PublishCreatingService.new({user: params[:user], publish: params[:publish]}).publishing
    end
end
