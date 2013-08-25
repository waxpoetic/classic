class Artist < ActiveRecord::Base
  validates :name, presence: true
  mount_uploader :cover_image, MastheadUploader
  mount_uploader :photo_image, PhotoUploader
  has_many :releases
end
