class InsertValuesInPlanTable < ActiveRecord::Migration
  def up
    Plan.create(:name => "Basic", :price => 5, :days => 15, :projects => "1", :members => "2", :stripe_plan_id => 1)
  end

  def down
    Plan.delete_all(:stripe_plan_id => 1)
  end
end
