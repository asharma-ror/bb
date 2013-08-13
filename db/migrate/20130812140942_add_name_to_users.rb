class AddNameToUsers < ActiveRecord::Migration
  def change
  	User.all.each do |user|
      user.update_attributes(:name => user.email.split('@')[0], :initials => user.email.split('@')[0][0,2])
	  end
  end
end
