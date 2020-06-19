class Public::OrdersController < ApplicationController
  before_action :authenticate_customer
  before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:select_address] == '0'
      @order.postal_code = current_customer.postal_code
      @order.destination = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:select_address] == '1'
      @selected_address = current_customer.addresses.find(params[:address_id])
      @order.postal_code = @selected_address.postal_code
      @order.destination = @selected_address.destination
      @order.name = @selected_address.name
    elsif params[:select_address] == '2'
      # 10行目の時点で入っている
      # 以下残骸
      # @order.postal_code = params[:new_address][:postal_code]
      # @order.destination = params[:new_address][:destination]
      # @order.name = params[:new_address][:name]
    else
      render :new
    end
  end

  def error
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.grand_total = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @cart_items.each do |cart_item|
        OrderDetail.create(
          order_id: @order.id,
          item_id: cart_item.item_id,
          price: cart_item.item.with_tax_price,
          amount: cart_item.amount
        )
        cart_item.destroy
      end
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.includes(:order_details, :items).page(params[:page]).reverse_order
  end

  def show
    @order = current_customer.orders.find_by(id: params[:id])
    if @order
      @order_details = @order.order_details.includes(:item)
    else
      redirect_to orders_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :destination, :name, :payment_method)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    unless @cart_items.first
      redirect_to items_path
    end
  end
end
