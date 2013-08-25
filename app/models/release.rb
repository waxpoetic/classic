class Release < ActiveRecord::Base
  belongs_to :artist
  has_many :products

  validates :name, presence: true
  validates :catalog_number, presence: true
  validates :released_on, presence: true
  validates :artist, presence: true

  mount_uploader :cover_image, CoverUploader
end
