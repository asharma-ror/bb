require 'spec_helper'

describe Authentication do
  
  describe "belong_to association with auction_admin" do
    it { should belong_to(:auction_admin) }
    
    it "should have many authentications" do
      r = Authentication.reflect_on_association(:auction_admin)
      r.macro.should == :belongs_to
    end
  end
  
end
