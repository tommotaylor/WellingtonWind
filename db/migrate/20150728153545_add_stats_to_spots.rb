class AddStatsToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :current_wind_direction, :integer
    add_column :spots, :current_wind_speed, :integer
    add_column :spots, :trend, :string
  end
end
