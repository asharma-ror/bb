namespace :admin_setting do
  desc "Create admin setting to old auction admin"
  task :migrate => :environment do
    admins = AuctionAdmin.find(:all)
    admins.each do |admin|
      AdminSetting.create(:auction_admin_id => admin.id) if admin.admin_setting.blank?
    end
  end
 
end
