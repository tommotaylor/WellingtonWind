class Spot < ActiveRecord::Base
  has_and_belongs_to_many :categories

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    Spot.where("name LIKE ?", "%#{search_term}%")
  end

  def forecast
    ForecastIO.forecast(latitude, longitude)
  end

  def current_wind_speed
    current_weather = self.forecast["currently"]
    current_weather["windSpeed"]*0.868976
  end

  def current_wind_direction
    current_weather = self.forecast["currently"]
    Geocoder::Calculations.compass_point(current_weather["windBearing"])
  end
end