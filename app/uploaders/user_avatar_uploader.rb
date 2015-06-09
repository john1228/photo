# encoding: utf-8

class UserAvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  storage :file

  def store_dir
    "images/#{model.class.to_s.underscore}/avatar"
  end

  version :thumb do
    process :resize_to_fit => [90, 90]
  end

  def default_url
    'http://192.168.0.126/images/default/user.jpg'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{Time.now.strftime('%Y/%m/%d')}/#{secure_token}.#{file.extension}" if original_filename
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
