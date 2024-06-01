class OrdersPayments
  include ActiveModel::Model

  attr_accessor :token, :item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number

  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
  end

  def save
    # 購入情報を保存
    purchase = Purchase.create(item_id:, user_id:)
    # 配送先情報を保存
    ShippingAddress.create(postal_code:, prefecture_id:, city:, address:,
                           building:, phone_number:, purchase_id: purchase.id)
  end
end
