class Item < ApplicationRecord
  # テーブルとのアソシエーション
  belongs_to :user
  has_one :order

  # アクティブハッシュとのアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :delivery_area
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :shipping_date

  # active_storageとのアソシエーション
  # （items・active_storage_blobsテーブルを関連付け）
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :delivery_area_id
    validates :shipping_date_id
    # 300円以上かつ9,999,999円以下で、半角数字でないと入力不可
    validates :price, numericality: { only_integer: true, message: 'Half-width number' }
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is out of setting range' }
  end

  # ジャンルの選択が「--」の時は保存不可
  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :delivery_area_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :shipping_date_id
  end

  def sold_out?
  end
end
