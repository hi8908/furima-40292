class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_item_sold_out, only: [:index, :create]

  def index
    @order_payment = OrdersPayments.new
  end

end
