class Favourite < ActiveRecord::Base

  belongs_to :user
  belongs_to :spot
  validates_numericality_of :list_order, only_integer: true

  def current_wind_speed
  end

end