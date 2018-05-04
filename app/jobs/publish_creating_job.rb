# Documentation
class PublishCreatingJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    if args[:publish].published?
      PublishEditingService.new(user: args[:user], publish: args[:publish]).editing
    else
      PublishCreatingService.new(user: args[:user], publish: args[:publish]).publishing
    end
  end
end
