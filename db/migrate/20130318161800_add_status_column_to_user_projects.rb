class AddStatusColumnToUserProjects < ActiveRecord::Migration
  def change
    add_column :user_projects, :status, :boolean
  end
end
