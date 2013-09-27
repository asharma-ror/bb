class CreateChatFiles < ActiveRecord::Migration
  def change
    create_table :chat_files do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
