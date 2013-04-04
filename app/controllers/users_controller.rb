class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_user_plan
  
  def upgrade
  end
end
