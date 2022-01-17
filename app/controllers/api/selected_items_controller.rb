class Api::SelectedItemsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    before_action :set_item, only: [:update, :destroy]
    skip_before_action :authorize
    
    def index 
        items = SelectedItem.all 
        render json: items,  status: :ok
    end

    def update 
        @item.update(item_params)
        render json: @item, status: :accepted
    end

    def destroy 
        @item.destroy 
        head :no_content
    end


    private

    def set_item
        @item = SelectedItem.find(params[:id])
    end

    def item_params
        params.permit(:quantity, :order_id, :cart_id, :sku_id)
    end

    def render_not_found_response
        render json: { errors: ['Selected Item Not Found'] }, status: :not_found
    end
end
