# encoding: utf-8

require 'carrierwave/processing/mini_magick'

class CoverUploader < ImageUploader
  include CarrierWave::MiniMagick

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "http://placehold.it/250x250&text=Album"
  end

  # Scale to 250px square
  process :scale => [250, 250]
  def scale width, height
    # TODO: Scale with MiniMagick
  end
end
