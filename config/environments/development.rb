Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    # config.cache_store = :dalli_store, Rails.application.secrets.memcached_addresses,
    # { namespace: "#{Rails.env}_kontaktliste", expires_in: 1.day, compress: true }
    # config.public_file_server.headers = {
    #   'Cache-Control' => 'public, max-age=172800'
    # }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.default_url_options = { host: Rails.application.secrets.domain_name }
  Rails.application.routes.default_url_options = { host: Rails.application.secrets.domain_name }
  config.action_controller.default_url_options = { host: Rails.application.secrets.domain_name }

  config.action_controller.asset_host = Rails.application.secrets.domain_name

  config.paperclip_defaults = {
    storage: :s3,
    s3_region: Rails.application.secrets.aws_s3_region,
    region: Rails.application.secrets.aws_s3_region,
    s3_protocol: 'https',
    bucket: Rails.application.secrets.aws_s3_bucket_name,
    url: ':rails_env/images/:class/:attachment/:id/:style/:filename',
    path: ':rails_env/images/:class/:attachment/:id/:style/:filename',
    credentials: {
      access_key_id: Rails.application.secrets.aws_access_key_id,
      secret_access_key: Rails.application.secrets.aws_access_key_secret
    }
  }
end
