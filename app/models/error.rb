class Error < ActiveRecord::Base
  extend Enumerize
  
  belongs_to :project
  has_one :error_trace, :dependent => :destroy
  
  attr_accessible :count, :desc, :status, :title, :url
  
  enumerize :status, :in => { active: 1, resolved: 2 }, scope: :having_status
end
