class UserProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  attr_accessible :role, :user_id, :project_id, :status

  scope :pending, where(:status => false)
end
