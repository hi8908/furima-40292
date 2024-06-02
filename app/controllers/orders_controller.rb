class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :non_purchased_item, only: [:index, :create]

  def index
    @orders_payments = OrdersPayments.new
  end

  def create
    @orders_payments = OrdersPayments.new(order_params)
    if @orders_payments.valid?
      pay_item
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
    params.require(:orders_payments).permit( :postcode, :delivery_area_id, :city, :address, :building, :phone_number).merge(
     token: params[:token] ,user_id: current_user.id, item_id: @item.id
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
