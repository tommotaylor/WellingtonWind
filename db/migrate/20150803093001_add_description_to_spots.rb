class AddDescriptionToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :description, :string
  end
end
