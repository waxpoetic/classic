# A means by which Releases are sold through the online store, the
# Product represents a "version" of a given Release. For example, a
# Release can be sold in either WAV or 320kbps MP3, or possibly in a ZIP
# file containing the stems of a given track. This model represents
# those underlying versions that are not part of the traditional
# "catalog" that Release is meant to model.
class Product < ActiveRecord::Base
  belongs_to :release

  validates :name, presence: true
  validates :price, presence: true

  mount_uploader :file, MusicUploader

  alias_attribute :merchandise?, :is_merchandise

  scope :merchandise, -> { where is_merchandise: true }
end
