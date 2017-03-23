Apipie.configure do |config|
  config.app_name                = 'Kontaktliste'
  config.copyright               = "&copy; #{Time.zone.today.year} Kontaktliste"
  config.api_base_url            = '/api/v1/'
  config.doc_base_url            = '/docs'
  config.default_version         = '1'
  config.api_controllers_matcher = Rails.root.join(Rails.root, 'app', 'controllers', '**', '*.rb')
  config.api_routes              = Rails.application.routes
  config.show_all_examples       = true
  config.use_cache               = false
end
