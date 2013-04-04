class Plan < ActiveRecord::Base
  attr_accessible :days, :name, :price, :projects, :members
  belongs_to :subscription
end
