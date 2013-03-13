# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
e1 = EventType.find_or_create_by_name(:name => "Online Auction", :description => "Online auction are normal auction that are run online and our site chooses a winner once the end time arrives. means It is used for online auction.")
e2 = EventType.find_or_create_by_name(:name => "Live Silent Auction With paper bid sheets", :description => "")
e3 = EventType.find_or_create_by_name(:name => "Live Silent Auction With Mobile Bidding", :description => "")
e4 = EventType.find_or_create_by_name(:name => "Pre bid Auction", :description => "Pre-bid is like an online auction but no winner is assigned at the end time. It is used for bidding before a live event.")    
e5 = EventType.find_or_create_by_name(:name => "Catalog View", :description => "It is used for allowing your visitors to preview the items that will be at the live event but no bidding is allowed.")   
e6 = EventType.find_or_create_by_name(:name => "Sell Event Tickets", :description => "")
e7 = EventType.find_or_create_by_name(:name => "Fund A Need", :description => "")    
     
    
    
    
