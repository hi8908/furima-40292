class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @orders_payments = OrdersPayments.new
  end

  def create
    @orders_payments = OrdersPayments.new(order_params)
    if @orders_payments.valid?
      @orders_payments.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:orders_payments).permit(:token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id
    )
  end
end
