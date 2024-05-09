class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  validates :nickname, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true,length: { minimum: 6 },format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "は半角英数字混合で入力してください" }
  #全角ひらがな、全角カタカナ、漢字
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龠々ー]+\z/, message: "は全角で入力してください" }
  validates :first_name, format:{ with: /\A[ぁ-んァ-ン一-龠々ー]+\z/, message: "は全角で入力してください" }
  # 全角カタカナ
  validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナで入力してください" }
  
  validates :birthday, presence: true
end
