class AddCampfireToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :campfire_room, :string
  	add_column :projects, :campfire_subdomain, :string
  	add_column :projects, :campfire_token, :string
		add_column :projects, :campfire_activate, :boolean
		add_column :projects, :campfire_room_id, :integer
  end
end
