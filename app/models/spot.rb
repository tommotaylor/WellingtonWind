class Spot < ActiveRecord::Base
  has_and_belongs_to_many :categories

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    Spot.where("name LIKE ?", "%#{search_term}%")
  end
end