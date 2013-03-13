require 'spec_helper'

describe AuctionAdminRegistrationsController do
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:auction_admins]
    #sign_in FactoryGirl.create(:admin)
  end

  describe "POST 'create'" do

    it "return on user sign up page" do
      post 'create', :auction_admins => {:username => '', :full}
      response.should be_success  
      
    end
  end
end
