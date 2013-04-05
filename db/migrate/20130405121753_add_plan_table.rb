class AddPlanTable < ActiveRecord::Migration
  def up
    add_column :plans, :stripe_plan_id, :integer
  end

  def down
    remove_column :plans, :stripe_plan_id
  end
end
