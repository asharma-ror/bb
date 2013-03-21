class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.integer :role
      t.references :project
      t.references :user

      t.timestamps
    end
    add_index :user_projects, :project_id
    add_index :user_projects, :user_id
  end
end
