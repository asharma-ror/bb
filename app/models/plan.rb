class Plan < ActiveRecord::Base
  attr_accessible :days, :name, :price, :projects, :members, :stripe_plan_id
  has_one :subscription
end
