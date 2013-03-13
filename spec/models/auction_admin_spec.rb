require 'spec_helper'

describe AuctionAdmin do
  describe "has_many association with autheticaion" do
    it { should have_many(:authentications) }
    
    it "should have many authentications" do
      r = AuctionAdmin.reflect_on_association(:authentications)
      r.macro.should == :has_many
    end
  end
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_acceptance_of(:terms_of_service) }

  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }

  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("a@b.com").for(:email) }
  it { should_not allow_value("+07C-DDD-1111").for(:phone_number) }
  it { should allow_value("+111-111-111").for(:phone_number) }
  it { should allow_value("newyork").for(:city) }
  it { should_not allow_value("london12").for(:city) }
  it { should allow_value("123456").for(:zip_code) }
  it { should_not allow_value("123c45").for(:zip_code) }
  it { should allow_value("russia").for(:country) }
  it { should_not allow_value("russia12").for(:country) }

  before(:all) do
    @auction_admin_attributes =[:email, :password, :first_name, :last_name, :username,
    :phone_number, :address, :city, :state, :zip_code, :country,
    :terms_of_service]
  end

  describe "#is_profile_complete?" do
    before(:each) do
      @auction_admin = FactoryGirl.create(:auction_admin)
    end

    it "should return false given that profile is not complete yet" do
      @auction_admin.zip_code = ''
      @auction_admin.save.should be_true
      @auction_admin.is_profile_complete?.should be_false
    end

    it "should return false given that profile is not complete yet" do
      @auction_admin.timezone = "Alaska"
      @auction_admin.save.should be_true
      @auction_admin.is_profile_complete?.should be_true
    end

  end

  describe "#profile_complete_in_per" do
    before(:each) do
      @auction_admin = FactoryGirl.create(:auction_admin)
    end
    it "should return false given that profile is not complete yet" do
      @auction_admin.profile_complete_in_per.should_not eq('100')
    end
    it "should return true given that profile is complete" do
      @auction_admin.timezone = "Alaska"
      @auction_admin.save.should be_true
      @auction_admin.profile_complete_in_per.should eq('100')
    end
  end

end

