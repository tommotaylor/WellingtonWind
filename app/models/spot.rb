class Spot < ActiveRecord::Base
  has_and_belongs_to_many :categories

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode


  def self.search_by_name(search_term)
    return [] if search_term.blank?
    Spot.where("name LIKE ?", "%#{search_term}%")
  end

  def forecast
    @forecast ||= ForecastIO.forecast("#{latitude}","#{longitude}")
  end

  def save_current_wind_speed
    current_weather = forecast["currently"]
    self.current_wind_speed = (current_weather["windSpeed"]*0.868976).round(0)
  end

  def save_current_wind_direction
    current_weather = @forecast["currently"]
    self.current_wind_direction = Geocoder::Calculations.compass_point(current_weather["windBearing"])
  end

end