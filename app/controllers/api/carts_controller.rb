class Api::CartsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    before_action :set_cart
    skip_before_action :authorize
    

    def show 
        if !@cart
            @cart = Cart.new
            if @current_user 
                @cart.user = @current_user
            end
            @cart.save
        end

        render json: @cart
    end

    private

    def set_cart
        @cart = Cart.find_by_id(session[:cart_id])
    end

    def render_not_found_response
        render json: { errors: ['No Cart Found'] }, status: :not_found
    end
end
