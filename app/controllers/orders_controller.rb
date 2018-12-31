class OrdersController < ApplicationController
  def index
    @shipped_orders = Order.shipped
    @unshipped_orders = Order.unshipped
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    #quantity set to nil so that unused line items are deleted
    3.times { @order.line_items.build(quantity: nil).build_widget }
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to order_path(@order)
    else
      render 'new'
    end
  end

  private

    def order_params
      params.require(:order).permit(
        line_items_attributes: [:quantity, :unit_price, :order_id,
        widget_attributes: [:name, :msrp, :line_item_id]]
      )
    end
end
