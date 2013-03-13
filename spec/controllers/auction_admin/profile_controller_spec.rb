require 'spec_helper'

def login_auction_admin
  @request.env["devise.mapping"] = Devise.mappings[:auction_admin]
  @auction_admin = FactoryGirl.create(:auction_admin)
  sign_in @auction_admin
end
  
describe AuctionAdmin::ProfilesController do
  before(:each) do
    login_auction_admin
  end
          
  it "should have a current_auction_admin" do
    subject.current_auction_admin.should_not be_nil
  end

  it "shouldn't visit any page when admin is not logged in" do
    sign_out @auction_admin
    get :show
    response.should redirect_to("/auction_admins/sign_in")
  end
  
  describe "GET #show" do
    it "assigns the requested auction_admin to @auction_admin" do
      get :show
      assigns(:auction_admin).should eq(@auction_admin)
    end
    
    it "renders the #show view" do
      get :show, id: @auction_admin.id
      response.should render_template :show
    end
  end
  
  describe "PUT #change_password" do
    it "should not update password given password_confirmation nil" do
      put "change_password", :id => @auction_admin.id, :auction_admin => {:password => "123456", :password_confirmation => nil, :current_password => 'new_password'}
      flash[:alert].should eq "Password does not match confirmation"
      response.should render_template("change_password")
    end
    
    it "should not update password given password and password_confirmation are different" do
      put "change_password", :id => @auction_admin.id, :auction_admin => {:current_password => '123456', :password => "1234567", :password_confirmation => "12345678"}      
      flash[:alert].should eq "Password does not match confirmation"
      response.should render_template("change_password")
    end

    it "should not update password given current password nil" do
      put "change_password", :id => @auction_admin.id, :auction_admin => {:current_password => nil, :password => "1234567", :password_confirmation => "1234567"}
      flash[:alert].should eq "Password does not match confirmation"
      response.should render_template("change_password")
    end
    
    it "should update password given valid password and password_confirmation" do
      put "change_password", :id => @auction_admin.id, :auction_admin => {:current_password => '123456', :password => "1234567", :password_confirmation => "1234567"}
      flash[:notice].should eq "Password updated successfully"
      @auction_admin.reload
      response.should redirect_to auction_admin_dashboard_index_path
    end
  end

  describe "PUT #change_username" do
    it "should not update invalid username" do
      put "change_username", :id => @auction_admin.id, :auction_admin => {:username => "user@#%"}
      subject.current_auction_admin.errors[:username][0].should eq("should at-least contain 4 valid characters")
      response.should render_template("change_username")
    end 
    
    it "should update valid username" do
      put "change_username", :id => @auction_admin.id, :auction_admin => {:username => "username"}
      flash[:notice].should eq "Username updated successfully"
      @auction_admin.reload
      @auction_admin.username.should eq("username")
      response.should redirect_to auction_admin_dashboard_index_path
    end    
  end
  
end
