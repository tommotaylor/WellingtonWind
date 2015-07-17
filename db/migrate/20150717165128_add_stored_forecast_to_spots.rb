class AddStoredForecastToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :stored_forecast, :string
  end
end
