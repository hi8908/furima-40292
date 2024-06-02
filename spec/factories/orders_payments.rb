FactoryBot.define do
  factory :orders_payments do
    token { 'tok_abcdefghijk00000000000000000' }
    item_id { Faker::Number.number(digits: 1) }
    user_id { Faker::Number.number(digits: 1) }
    postcode { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    delivery_area_id{ Faker::Number.between(from: 2, to: 47) } # 1 is invalid, so start from 2
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
  end
end
