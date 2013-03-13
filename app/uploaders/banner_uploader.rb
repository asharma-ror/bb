# encoding: utf-8
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mime_types'

class BannerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  include CarrierWave::RMagick
  process :set_content_type
  storage :file

 
  def store_dir
    'uploads/auction/event/banner/'
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  version :banner do
    process :resize_to_fill => [800,100]
  end

end
