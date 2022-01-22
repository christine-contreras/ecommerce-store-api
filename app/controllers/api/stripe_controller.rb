class Api::StripeController < ApplicationController
    before_action :set_stripe_key
    skip_before_action :authorize
    
    def checkout 
        shipping_amount = params[:shipping].to_i * 100
        orderItems = params[:items].collect do |item|
            selected_item = SelectedItem.find_by(id: item)

            {
                price_data: {
                    currency: 'usd',
                    product_data: {
                        name: selected_item.sku.product.title,
                        images: [selected_item.sku.image_url]
                    },
                    unit_amount: selected_item.price.to_i * 100

                },
                quantity: selected_item.quantity,

             }

        end
        
        session = Stripe::Checkout::Session.create({
        line_items: orderItems,
        payment_method_types: ['card'],
        shipping_address_collection: {
            allowed_countries: ['US', 'CA'],
            },
            shipping_options: [
            {
                shipping_rate_data: {
                type: 'fixed_amount',
                fixed_amount: {
                    amount: shipping_amount,
                    currency: 'usd',
                },
                display_name: 'Standard shipping',
                # Delivers between 5-7 business days
                delivery_estimate: {
                    minimum: {
                    unit: 'business_day',
                    value: 5,
                    },
                    maximum: {
                    unit: 'business_day',
                    value: 7,
                    },
                }
                }
            },
            {
                shipping_rate_data: {
                type: 'fixed_amount',
                fixed_amount: {
                    amount: 1500,
                    currency: 'usd',
                },
                display_name: 'Next day air',
                # Delivers in exactly 1 business day
                delivery_estimate: {
                    minimum: {
                    unit: 'business_day',
                    value: 1,
                    },
                    maximum: {
                    unit: 'business_day',
                    value: 1,
                    },
                }
                }
            },
            ],
        mode: 'payment',
        success_url:  ENV["WEBSITE_URL"] + '/order-confirmation?session_id={CHECKOUT_SESSION_ID}',
        cancel_url:    ENV["WEBSITE_URL"],
        })

        render json: {url: session.url}, status: :see_other
    end

    def order_success
        order = Order.find_by(session_id: params[:session_id])

        if !order  
            create_order 
            update_items    
        else 
            @order = order
        end
        
        render json: @order, include: ['user', 'selected_items', 'selected_items.sku'], status: :accepted
    end


    private 

    def set_stripe_key
        Stripe.api_key = ENV["STRIPE_API_KEY"]
    end

    def create_order 
        session = Stripe::Checkout::Session.retrieve(params[:session_id])
        customer = Stripe::Customer.retrieve(session.customer)
        @current_user.update(stripe_id: customer.id)
        @order = @current_user.orders.create(
            session_id: params[:session_id],
            address: session.shipping.address,
            name: customer.name,
            email: customer.email,
            amount: session.amount_total / 100,
            status: 'Pending'
            ) 
        @order.invoice = "#{customer.invoice_prefix}-#{@order.id}"
        @order.save
    end

    def update_items 
        params[:items].each do |item|
            selected_item = SelectedItem.find_by(id: item)
            sku_qty = selected_item.sku.quantity - selected_item.quantity
            selected_item.sku.update(quantity: sku_qty)
            selected_item.update(order_id: @order.id, cart_id: nil)
        end
    end
end
