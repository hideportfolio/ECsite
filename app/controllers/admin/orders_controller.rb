class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin
  before_action :ensure_order, only: [:show, :update]

  def index
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders.page(params[:page]).reverse_order
    else
      @orders = Order.includes(:customer).page(params[:page]).reverse_order
    end
  end

  def show
    @order_details = @order.order_details.includes(:item)
    @customer = @order.customer
  end

  def update
    @order.update(order_params)
    if @order.confirm_deposit?
      @order.order_details.update_all(making_status: 1)
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def ensure_order
    @order = Order.find_by(id: params[:id])
    unless @order
      redirect_to admin_orders_path
    end
  end
end
