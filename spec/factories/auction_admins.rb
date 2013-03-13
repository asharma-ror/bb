# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auction_admin do
    first_name Faker::Name.first_name
    last_name  Faker::Name.first_name
    username "Testing"
    password "123456"
    password_confirmation "123456"
    email "testing@gmail.com"
    phone_number "+111-333-4444"
    address "port villa"
    city "abcde"
    state "xyz"
    zip_code "432561"
    country "russia"
  end
end
