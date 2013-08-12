# encoding: utf-8

class MastheadUploader < ImageUploader
  include CarrierWave::MiniMagick

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "http://placehold.it/1000x400&text=Album"
  end

  # Scale to common width
  process :scale => [1000, 400]
  def scale width, height
    # TODO: Scale with MiniMagick
  end
end
