# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{table_name}/#{model.id}/#{mounted_as}"
  end

  def table_name
    model.class.to_s.underscore.pluralize
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
