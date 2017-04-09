class PublishCreatingJob < ApplicationJob
    queue_as :default

    def perform(params)
        if params[:publish].photo_id.nil?
            PublishCreatingService.new({user: params[:user], publish: params[:publish]}).publishing
        else
            PublishEditingService.new({user: params[:user], publish: params[:publish]}).editing
        end
    end
end
