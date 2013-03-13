# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :error_trace do
    error nil
    application "MyText"
    full "MyText"
  end
end
