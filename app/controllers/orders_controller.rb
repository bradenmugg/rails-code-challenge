class OrdersController < ApplicationController
  def index
    @shipped_orders = Order.shipped
    @unshipped_orders = Order.unshipped
  end

  def show
    @order = Order.find(params[:id])
  end
end
