Plan.create(:days=> 30, :name=> "Basic", :price=> 5, :projects=>"1", :members=> "", :stripe_plan_id=>"") if Plan.first.blank?
