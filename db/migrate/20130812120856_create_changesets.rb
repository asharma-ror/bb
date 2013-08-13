class CreateChangesets < ActiveRecord::Migration
  def change
    create_table :changesets do |t|
      t.references :story
      t.references :project
      t.timestamps
    end
  end
end
