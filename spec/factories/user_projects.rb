# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_project do
    role 1
    project nil
    user nil
  end
end
