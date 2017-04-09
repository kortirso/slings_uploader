class PublishDeletingJob < ApplicationJob
    queue_as :default

    def perform(params)
        PublishDeletingService.new({user: params[:user], publish: params[:publish]}).deleting
    end
end
