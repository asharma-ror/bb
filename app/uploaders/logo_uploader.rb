# encoding: utf-8
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mime_types'

class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick
  process :set_content_type
  storage :file

 
  def store_dir
    'uploads/auction/event/logo/'
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  version :logo do
    process :resize_to_fill => [100,100]
  end

end
