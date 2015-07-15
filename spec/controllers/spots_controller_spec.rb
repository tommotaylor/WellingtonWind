require 'rails_helper'

describe SpotsController do
  describe "GET index" do
    it "sets the @spots variable" do
      spot = Fabricate(:spot)
      spot2 = Fabricate(:spot)
      get :index
      expect(assigns(:spots)).to eq([spot, spot2])
    end
  end

  describe "GET show" do
    it "sets the @spot variable" do
      spot = Fabricate(:spot)
      get :show, id: spot.id
      expect(assigns(:spot)).to eq(spot)
    end
  end

  describe "GET search" do
    it "assigns @results" do
      spot = Fabricate(:spot)
      get :search, search_term: "#{spot.name}"
      expect(assigns(:results)).to eq([spot])
    end
  end
end