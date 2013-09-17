class User < ActiveRecord::Base

  # FIXME - DRY up, repeated in Story model
  JSON_ATTRIBUTES = ["id", "name", "initials", "email"]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :initials, :email_delivery, :email_acceptance, 
                  :email_rejection, :locale

  attr_accessor :was_created

  validates :name, :presence => true
  validates :initials, :presence => true

  # attr_accessible :title, :body

  validates :email, :uniqueness => true

  has_many :projects, :dependent => :destroy, :through => :user_projects
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  has_many :user_projects, :dependent => :destroy
  has_many :active_projects, :through => :user_projects, :source => :project , :conditions => { "user_projects.status" => true }
  has_many :subscriptions, :dependent => :destroy

  def to_s
    "#{name} (#{initials}) <#{email}>"
  end

  def as_json(options = {})
    super(:only => JSON_ATTRIBUTES)
  end
  
  def is_project_admin?(project)
    self == user_projects.where(project_id: project).creator
  end

end
