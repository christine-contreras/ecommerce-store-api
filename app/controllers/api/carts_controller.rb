class Api::CartsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # before_action :set_cart
    skip_before_action :authorize
    

    def show 
        if session.include? :cart_id
            set_cart
        else
            create_cart
        end

        render json: @cart
    end

    private

    def set_cart
        @cart = Cart.find_by(id: session[:cart_id])
    end

    def create_cart
        @cart = Cart.create
        session[:cart_id] = @cart.id
        @cart
    end

    def render_not_found_response
        render json: { errors: ['No Cart Found'] }, status: :not_found
    end
end
