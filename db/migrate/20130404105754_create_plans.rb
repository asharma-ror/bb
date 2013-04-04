class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :price
      t.integer :days
      t.string :projects
      t.string :members
      t.timestamps
    end
  end
end
