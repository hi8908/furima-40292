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
      it 'user_idが空でなければ保存できる' do
        @orders_payments.user_id = 1
        expect(@orders_payments).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @orders_payments.item_id = 1
        expect(@orders_payments).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @orders_payments.postal_code = '123-4560'
        expect(@orders_payments).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @orders_payments.prefecture_id = 2
        expect(@orders_payments).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @orders_payments.city = '横浜市'
        expect(@orders_payments).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @orders_payments.address = '青山1-1-1'
        expect(@orders_payments).to be_valid
      end
      it '電話番号が11桁以内かつハイフンなしであれば保存できる' do
        @orders_payments.phone_number = '09012345678'
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
        @orders_payments.postal_code = nil
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @orders_payments.postal_code = '1234567'
        @orders_payments.valid?
        expect(@orders_payments.errors.full_messages).to include('Postal code is invalid')
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
    end
  end
end
