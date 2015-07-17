class Favourite < ActiveRecord::Base

  belongs_to :user
  belongs_to :spot

  def current_wind_speed
  end

end