class Artist < ActiveRecord::Base
  validates :name, presence: true
  mount_uploader :cover_image, MastheadUploader
end
