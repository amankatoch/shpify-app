ShopifyApp.configure do |config|
  config.api_key = Rails.application.secrets[:shopify_app_key]
  config.secret = Rails.application.secrets[:shopify_app_secret]
  config.redirect_uri = Rails.application.secrets[:shopify_app_redirect_uri]
  config.scope = Rails.application.secrets[:shopify_app_scope]
  config.embedded_app = true
end
