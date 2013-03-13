class HomeController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:dashboard]
  
  def index
  
  end
  
  def dashboard
    
    render layout: "auction"
  end
end
