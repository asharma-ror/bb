class AddGeneratedAtError < ActiveRecord::Migration
  def change
    add_column :errors, :generated_at, :datetime
  end
end
