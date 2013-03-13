class ErrorTrace < ActiveRecord::Base
  belongs_to :error
  attr_accessible :application, :full
  
  serialize :application, Array
  serialize :full, Array
end
