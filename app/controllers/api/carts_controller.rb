class Api::CartsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # before_action :set_cart
    skip_before_action :authorize
    

    def show 
        byebug
        if session.include? :cart_id
            byebug
            set_cart
        else
            byebug
            create_cart
        end

        render json: @cart
    end

    private

    def set_cart
        @cart = Cart.find_by(id: session[:cart_id])
    end

    def create_cart
        @cart = Cart.new
        if @current_user 
            @cart.user = @current_user
        end
        @cart.save
        byebug
        session[:cart_id] = @cart.id
        @cart
    end

    def render_not_found_response
        render json: { errors: ['No Cart Found'] }, status: :not_found
    end
end
