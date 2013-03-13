class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.references :project
      t.integer :status
      t.integer :count
      t.text :title
      t.text :desc
      t.text :url

      t.timestamps
    end
    add_index :errors, :project_id
  end
end
