class FavouritesController < ApplicationController

  before_action :require_user

  def index
    @favourites = current_user.favourites
  end

end