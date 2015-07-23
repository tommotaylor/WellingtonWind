class FavouritesController < ApplicationController

  before_action :require_user

  def index
    @favourites = current_user.favourites
  end

  def create
    spot = Spot.find(params[:spot_id])
    Favourite.create(user_id: current_user.id, spot_id: spot.id, list_order: bottom_of_queue) unless already_in_queue?(spot)
    redirect_to favourites_path
  end

  def destroy
    favourite = Favourite.find(params[:id])
    favourite.delete if favourite.user_id == current_user.id
    normalise_favourites
    redirect_to favourites_path
  end

  def update_favourites
    update_list
    normalise_favourites
  rescue ActiveRecord::RecordInvalid
    flash[:error] = "order must be a whole number"
  ensure
    redirect_to favourites_path
  end

private

  def bottom_of_queue
    current_user.favourites.count + 1
  end

  def already_in_queue?(spot)
    current_user.favourites.map(&:spot).include?(spot)
  end

  def normalise_favourites 
    current_user.favourites.each do |favourite|
      index = current_user.favourites.index(favourite)
      favourite.update_attributes(list_order: index + 1)
    end
  end

  def update_list
    ActiveRecord::Base.transaction do
      params[:favourites].each do |data|
        favourite = Favourite.find(data[:id])
        favourite.update_attributes!(list_order: data[:list_order]) if favourite.user_id == current_user.id
      end
    end
  end

end