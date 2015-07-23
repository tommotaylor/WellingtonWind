class SpotsController < ApplicationController

  def index
    @spots = Spot.all
    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @hash = Gmaps4rails.build_markers(@spot) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
    end
  end

  def search
    @results = Spot.search_by_name(params[:search_term])
  end
end