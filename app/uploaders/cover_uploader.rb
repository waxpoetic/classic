# encoding: utf-8

class CoverUploader < ImageUploader
  include CarrierWave::MiniMagick
  storage :fog

  # Scale to 250px square
  process :scale => [250, 250]
  def scale width, height
    # TODO: Scale with MiniMagick
  end
end
