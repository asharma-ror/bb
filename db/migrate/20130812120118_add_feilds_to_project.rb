class AddFeildsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :point_scale, :string, :default => 'fibonacci'
    add_column :projects, :start_date, :date
    add_column :projects, :iteration_start_day, :integer, :default => 1
    add_column :projects, :iteration_length, :integer, :default => 1
    add_column :projects, :default_velocity, :integer, :default => 10
  end
end
