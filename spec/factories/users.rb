FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.unique.email }
    # ランダムで生成する際、英数字になるよう'2a'追加
    password { '2a' + Faker::Internet.unique.password(min_length: 6) }
    password_confirmation { password }
    last_name { '市村' }
    first_name { '裕章' }
    last_name_kana { 'イチムラ' }
    first_name_kana { 'ヒロアキ' }
    birthday { Faker::Date.birthday }
  end
end
