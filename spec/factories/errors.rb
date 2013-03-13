# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :error do
    project nil
    status 1
    count 1
    title "MyText"
    desc "MyText"
    url "MyText"
  end
end
