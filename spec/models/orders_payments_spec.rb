require 'rails_helper'

RSpec.describe OrdersPayments, type: :model do
  before do
    @orders_payments = FactoryBot.build(:orders_payments)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@orders_payments).to be_valid
      end
      it '建物名が空でも保存できること' do
        @orders_payments.building = ''
        expect(@orders_payments).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @orders_payments.user_id = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @orders_payments.item_id = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @orders_payments.postcode = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @orders_payments.postcode = '1234567'
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include('Postal code is invalid')
      end
      it '郵便番号に全角文字が含まれていると保存できないこと' do
        @orders_payments.postal_code = '１２３-４５６７'
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @orders_payments.prefecture_id = 1
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '都道府県が空だと保存できないこと' do
        @orders_payments.prefecture_id = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @orders_payments.city = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @orders_payments.address = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @orders_payments.phone_number = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @orders_payments.phone_number = '123-1234-1234'
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @orders_payments.phone_number = '123456789012'
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
    end
  end 
  end
end
