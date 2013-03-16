class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_errors, :dependent => :destroy, :class_name => "Error", :order => "generated_at Desc"
  has_many :error_trace, :through => :project_errors

  attr_accessible :key, :name, :user_id

  before_create :create_unique_identifier

  validates :name, :uniqueness => {:scope => :user_id}, :presence => true
  validates :key, :uniqueness => true


  def create_unique_identifier
    begin
    self.key = SecureRandom.hex(5) # or whatever you chose like UUID tools
    end while self.class.exists?(:key => key)
  end

end
