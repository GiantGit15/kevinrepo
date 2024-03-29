require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Journalesk
  class Application < Rails::Application

    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

    # Credentials can be added to config/application.yml like:
    # s3_bucket_name: "YOURBUCKETNAME"
    # aws_access_key_id: "YOURACCESSKEYID"
    # aws_secret_access_key: "YOURSECRERACCESSKEY"
    config.paperclip_defaults = {
        :storage => :s3,
        :s3_host_name => 's3.amazonaws.com',
        :s3_credentials => {
            :bucket => ENV['s3_bucket_name'],
            :access_key_id => ENV['aws_access_key_id'],
            :secret_access_key => ENV['aws_secret_access_key']
        }
    }

    config.active_job.queue_adapter = :delayed_job
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
