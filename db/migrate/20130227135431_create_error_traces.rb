class CreateErrorTraces < ActiveRecord::Migration
  def change
    create_table :error_traces do |t|
      t.references :error
      t.text :application
      t.text :full

      t.timestamps
    end
    add_index :error_traces, :error_id
  end
end
