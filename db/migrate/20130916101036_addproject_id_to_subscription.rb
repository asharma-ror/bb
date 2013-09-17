class AddprojectIdToSubscription < ActiveRecord::Migration
  def up
    add_column :subscriptions, :project_id, :integer
    add_column :subscriptions, :payment_profile_id, :string
  end

  def down
    remove_column :subscriptions, :project_id
    remove_column :subscriptions, :payment_profile_id
  end
end
