class AddNameOfAttrForFilepickerUrlToUser < ActiveRecord::Migration
  def up
    add_column :chat_files, :filepicker_url, :string
  end

  def down
    remove_column :chat_files, :filepicker_url
  end
end
