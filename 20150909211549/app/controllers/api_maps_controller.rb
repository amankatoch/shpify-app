class ApiMapsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    respond_to do |format|
      format.js do
        @map = Map.find(params[:shop_id])

        response = {
          api_key: @map.api_key,
          
          stores: @map.shop.stores
        }

        render json: response.to_json, callback: params[:callback]
      end
    end
  end
end
