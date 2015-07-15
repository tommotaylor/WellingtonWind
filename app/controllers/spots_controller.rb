class SpotsController < ApplicationController

  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def search
    @results = Spot.search_by_name(params[:search_term])
  end
end