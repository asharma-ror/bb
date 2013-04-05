class AddColsInSubscriptionTables < ActiveRecord::Migration
  def up
    add_column :subscriptions, :is_active, :boolean, :default => false
    add_column :subscriptions, :start_date, :datetime
    add_column :subscriptions, :end_date, :datetime
  end

  def down
    remove_column :subscriptions, :is_active
    remove_column :subscriptions, :start_date
    remove_column :subscriptions, :end_date
  end
end
