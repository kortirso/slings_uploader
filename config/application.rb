require_relative 'boot'

require 'rails/all'
require 'carrierwave'

Bundler.require(*Rails.groups)

module SlingsUploader
    class Application < Rails::Application
        config.active_record.schema_format = :ruby
        config.generators do |g|
            g.test_framework :rspec, fixtures: true, views: false, view_specs: false, helper_specs: false,
                routing_specs: false, controller_specs: true, request_specs: false
            g.fixture_replacement :factory_bot, dir: 'spec/factories'
        end
    end
end
