class Api::SkusController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    before_action :set_sku, only: [:update, :destroy]
    before_action :set_active_storage_host
    def index 
        skus = Sku.all 
        render json: skus, status: :ok
    end

    def create 
        sku = Sku.create(sku_params)
        sku.image.attach(params[:image])
        # url = url_for(@sku.image)
        render json: sku, status: :created
    end

    def update 
        @sku.update(sku_params)
        @sku.image.purge if @sku.image.attached?
        @sku.image.attach(params[:image])
        # url =  polymorphic_url(@sku.image)
        # byebug
        render json: @sku, status: :accepted
    end

    def destroy 
        @sku.destroy 
        head :no_content
    end


    private

    def set_sku
        @sku = Sku.find(params[:id])
    end

    def sku_params
        params.permit(:product_id, :size, :color, :price, :quantity, :image)
    end

    def render_not_found_response
        render json: { errors: ['Sku Not Found'] }, status: :not_found
    end

    def set_active_storage_host
        ActiveStorage::Current.host = 'http://localhost:3000' if ActiveStorage::Current.host.blank?
        true
    end

end
