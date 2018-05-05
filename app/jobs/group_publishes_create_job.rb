# Documentation
class GroupPublishesCreateJob < ApplicationJob
  queue_as :default

  def perform(args = {})
    publishes(args[:user]).each do |publish|
      GroupPublishCreateService.new(user: args[:user], publish: publish).publish
    end
  end

  private def publishes(user)
    Product.create_publishes(user)
  end
end
