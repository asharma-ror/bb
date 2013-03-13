# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_setting do
    title "MyString"
    description "MyText"
    logo "MyString"
    banner "MyString"
    terms_and_conditions "MyText"
    customize_invoice false
    customize_bid_sheet false
    background_color "MyString"
    currency "MyString"
    timezone "MyString"
    bidder_email false
    bidder_name false
    bidder_address false
    bidder_phone false
  end
end
