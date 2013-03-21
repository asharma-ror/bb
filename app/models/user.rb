class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates :email, :uniqueness => true

  has_many :projects, :dependent => :destroy, :through => :user_projects
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  has_many :user_projects, :dependent => :destroy
  has_many :active_projects, :through => :user_projects, :source => :project , :conditions => { "user_projects.status" => true }

end
