class AddFeildsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
    add_column :users, :initials, :string
    add_column :users, :locale, :string
    add_column :users, :email_delivery, :boolean, :default => true
    add_column :users, :email_acceptance, :boolean, :default => true
    add_column :users, :email_rejection, :boolean, :default => true
  end
end
