require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UrlShortener
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :user_name => ENV["SENDGRID_USERNAME"],
      :password => ENV["SENDGRID_PWD"],
      :domain => ENV["FQDN_#{Rails.env.upcase}_URL"],
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :authentication => :login,
      :enable_starttls_auto => true
    }


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
