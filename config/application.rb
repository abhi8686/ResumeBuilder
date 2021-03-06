require_relative 'boot'
require 'dotenv/load'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ResumeBuilder
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
   	config.aws_temp_path = Rails.root.join('public', 'temp-uploads')
    config.aws_credentials={
      access_key: ENV['ACCESS_KEY'],
      secret_access_key: ENV['SECRET_ACCESS_KEY']  ,
      bucket: ENV['BUCKET'],
      region: ENV['REGION']
    }
  end
end
