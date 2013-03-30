class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_errors, :dependent => :destroy, :class_name => "Error", :order => "generated_at Desc"
  has_many :error_trace, :through => :project_errors

  has_many :user_projects, :dependent => :destroy

  has_many :users, :dependent => :destroy, :through => :user_projects

  attr_accessible :key, :name, :pivotal_token, :pivotal_project_id, :pivotal_project_name, :campfire_room, :campfire_subdomain, :campfire_token, :campfire_activate, :campfire_room_id

  before_create :create_unique_identifier

  validates :name, :presence => true
  validates :key, :uniqueness => true


  def create_unique_identifier
    begin
    self.key = SecureRandom.hex(5) # or whatever you chose like UUID tools
    end while self.class.exists?(:key => key)
  end

end
