class ChatFile < ActiveRecord::Base
  attr_accessible :image, :name, :filepicker_url
  mount_uploader :image, ImageUploader
  validates :filepicker_url, presence: true
end
