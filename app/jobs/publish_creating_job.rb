class PublishCreatingJob < ApplicationJob
  queue_as :default

  def perform(params)
    if params[:publish].published?
      PublishEditingService.new(user: params[:user], publish: params[:publish]).editing
    else
      PublishCreatingService.new(user: params[:user], publish: params[:publish], photos_check: params[:photos_check]).publishing
    end
  end
end
