# encoding: utf-8

require 'carrierwave/processing/mini_magick'

class MastheadUploader < ImageUploader
  include CarrierWave::MiniMagick

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "http://placehold.it/1000x400&text=Album"
  end

  # Scale to the common width of 100x400
  process :resize_to_fill => [1000, 400]
end
