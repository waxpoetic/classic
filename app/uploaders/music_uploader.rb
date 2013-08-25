# encoding: utf-8
#
# An uploader for all Product files, which are currently assumed to be
# music.
class MusicUploader < CarrierWave::Uploader::Base
  storage :fog

  # All release data is stored on 'files.waxpoeticrecords.com/releases'
  def store_dir
    'releases/music'
  end

  # Only audio files and archives may be uploaded at this time.
  def extension_white_list
    %w(wav mp3 aif zip gz)
  end
end
