class FavouritesController < ApplicationController

  before_action :require_user

  def index
    @favourites = current_user.favourites
  end

  def create
    favourite = Favourite.create(user_id: current_user.id, spot_id: params[:spot_id])
    redirect_to favourites_path
  end

end