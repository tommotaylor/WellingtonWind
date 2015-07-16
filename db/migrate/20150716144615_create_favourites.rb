class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :list_order
      t.integer :user_id
      t.integer :spot_id

      t.timestamps
    end
  end
end
