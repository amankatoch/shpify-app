class ApplicationController < ActionController::Base
  include ShopifyApp::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    
    def current_shop
      shopify_shop = ShopifyAPI::Shop.current
      Shop.find_by(shopify_domain: shopify_shop.myshopify_domain)
    end
    helper_method :current_shop
end
