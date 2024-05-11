require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての入力項目が存在していると登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
        it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it '重複したemailが存在する場合は登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'emailは@を含まないと登録できない' do
          @user.email = 'testmail'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'passwordが空では登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが6文字以上で半角英数字を含まないと登録できない' do
          @user.password = '12345'
          @user.password_confirmation = '12345'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password is invalid")
        end
        it 'passwordとpassword_confirmationが不一致では登録できない' do
          @user.password = '12345a'
          @user.password_confirmation = '1234567a'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it '名字が全角で(漢字 カタカナ、ひらがな)でないと登録できない'do
          @user.last_name ='ichimura'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name is invalid')
        end
        it '名前が全角で(漢字、カタカナ、ひらがな)でないと登録できない'do
           @user.first_name ='hiroaki'
           @user.valid?
           expect(@user.errors.full_messages).to include('First name is invalid')
        end
         it '名字のフリガナが全角（カタカナ）でないと登録できない' do
           @user.last_name_kana = 'いちむら'
           @user.valid?
           expect(@user.errors.full_messages).to include('Last name kana is invalid')
        end
        it '名前のフリガナが全角（カタカナ）でないと登録できない' do
          @user.first_name_kana = 'ひろあき'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name kana is invalid')
        end
        it '生年月日が空欄だと保存できない' do
          @user.birthday = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end




