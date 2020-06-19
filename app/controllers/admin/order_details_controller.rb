class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin

  def update
    @order = Order.find_by(id: params[:order_id])
    if @order
      @order_detail = @order.order_details.find_by(id: params[:id])
      if @order_detail
        @order_detail.update(order_detail_params)
        if @order_detail.in_production?
          @order.in_production!
        elsif @order.are_all_details_completed?
          @order.preparing_shipment!
        end
      end
      redirect_to admin_order_path(@order)
    else
      redirect_to admin_orders_path
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
