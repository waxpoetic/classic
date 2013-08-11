class Release < ActiveRecord::Base
  belongs_to :artist
  attr_accessible :catalog_number, :description, :name, :released_on, :tracks
end
