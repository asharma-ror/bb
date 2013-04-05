class AddCancelatToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :canceled_date, :datetime
  end
end
