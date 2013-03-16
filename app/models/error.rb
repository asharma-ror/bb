class Error < ActiveRecord::Base
  extend Enumerize

  belongs_to :project
  has_one :error_trace, :dependent => :destroy

  attr_accessible :count, :desc, :status, :title, :url, :generated_at

  enumerize :status, :in => { active: 1, resolved: 2 }, scope: :having_status

  scope :resolved, where(:status => "2")
  scope :active, where(:status => "1")
end
