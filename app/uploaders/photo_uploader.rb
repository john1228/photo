# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :file
  process :store_dimensions

  def store_dir
    "images/#{model.class.to_s.underscore}"
  end

  version :thumb do
    process :resize_to_fit => [1080, nil]
    process :store_dimensions
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{Time.now.strftime('%Y/%m/%d')}/#{secure_token}.#{file.extension}" if original_filename
  end

  protected
  def store_dimensions
    if file && model
      img = MiniMagick::Image::new(file.file)
      rate = img.width/1080.to_f
      model.photo_height = 1080, img.height*rate.to_i
    end
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end
