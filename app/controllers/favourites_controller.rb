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

  def update_favourites
  end

private

  def bottom_of_queue
    current_user.favourites.count + 1
  end

  def already_in_queue?(spot)
    current_user.favourites.map(&:spot).include?(spot)
  end

end