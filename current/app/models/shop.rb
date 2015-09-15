# == Schema Information
#
# Table name: shops
#
#  id             :integer          not null, primary key
#  shopify_domain :string           not null
#  shopify_token  :string           not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Shop < ActiveRecord::Base
  include ShopifyApp::Shop
  include Rails.application.routes.url_helpers

  has_one :map, dependent: :destroy
  has_many :stores, dependent: :destroy

  after_create :setup_map

  def setup_map
    # Create map
    map = self.build_map
    map.save

    # Create front store page for map
    begin
      ShopifyAPI::Base.site = shopify_api_path
      # Make whatever calls to the API that you want here.
      store_mapper_page = ShopifyAPI::Page.new(
        title: 'Store Mapper',
        body_html: map_template
      )
      store_mapper_page.save
    ensure
      ShopifyAPI::Base.site = nil
    end
  end

  private
    
    def shopify_api_path
      "https://#{Rails.application.secrets[:shopify_app_key]}:#{self.shopify_token}@#{self.shopify_domain}/admin"
    end

    def map_template
      vars = {shop_id: self.id, api_map_url: api_map_url}
      ac = ActionController::Base.new()
      ac.render_to_string(partial: 'front_store/map.html.erb', locals: vars)
    end
end
