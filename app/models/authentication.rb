class Authentication < ActiveRecord::Base
	attr_accessible :auction_admin_id, :uid, :provider, :token
	belongs_to :auction_admin	
	
	def self.find_from_hash(hash)
		find_by_provider_and_uid(hash['provider'], hash['uid'])
	end

end
