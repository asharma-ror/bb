# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    user nil
    name "MyString"
    key "MyString"
  end
end
