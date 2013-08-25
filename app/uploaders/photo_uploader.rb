# encoding: utf-8

class PhotoUploader < ImageUploader
  include CarrierWave::MiniMagick

  def store_dir
    'artists/photos'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "http://placehold.it/450x300&text=BandPhoto"
  end

  process :resize_to_fill => [450,300]
end
