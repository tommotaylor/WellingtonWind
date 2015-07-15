class CreateCategoriesSpots < ActiveRecord::Migration
  def change
    create_table :categories_spots do |t|
      t.belongs_to :category
      t.belongs_to :spot
      t.timestamps
    end
  end
end
