class Api::OrdersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    skip_before_action :authorize, only: [:index]

    def index 
        orders = Order.all 
        render json: orders, include: ['user', 'selected_items', 'selected_items.sku'], status: :ok
    end


    private 

    def render_not_found_response
        render json: { errors: ['Order Not Found'] }, status: :not_found
    end

end
