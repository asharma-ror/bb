# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :auction do
    title "MyString"
    description "MyText"
    viewable_before_live false
    terms_and_conditions "MyText"
    customize_invoice false
    customize_bid_sheet false
    event_url "MyString"
    start_time "2013-02-07 13:29:09"
    end_time "2013-02-07 13:29:09"
    timezone "MyString"
    currency "MyString"
    proxy_bidding false
    pre_bidding false
    auto_assign_bidder_number false
  end
end
