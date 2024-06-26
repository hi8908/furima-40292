class OrdersPayments
  include ActiveModel::Model

  attr_accessor :token, :item_id, :user_id, :postcode, :delivery_area_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :delivery_area_id, numericality: { other_than: 0}
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    # 購入情報を保存
    order = Order.create(item_id:, user_id:)
    # 配送先情報を保存
    Payment.create(postcode:, delivery_area_id:, city:, address:,
                   building:, phone_number:, order_id: order.id)
  end
end
