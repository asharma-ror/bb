class AddFieldsToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :pivotal_token, :string
  	add_column :projects, :pivotal_project_id, :integer
  	add_column :projects, :pivotal_project_name, :string
  end
end
