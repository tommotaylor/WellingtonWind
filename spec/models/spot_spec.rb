require 'rails_helper'

describe Spot do
  it { should have_and_belong_to_many(:categories) }

  describe "#search_by_name" do
    it "returns an empty array when no result" do
      result = Spot.search_by_name("Pungerahu")
      expect(result).to eq([])
    end
    it "returns an array with one title when there is an exact match" do
      spot = Fabricate(:spot, name: "The Ditch")
      result = Spot.search_by_name("The Ditch")
      expect(result).to eq([spot])
    end
    it "returns an array with more than one title when there is more than one match" do
      the_ditch = Fabricate(:spot, name: "The Ditch")
      the_ditch_east = Fabricate(:spot, name: "The Ditch East")
      result = Spot.search_by_name("The Ditch")
      expect(result).to eq([the_ditch, the_ditch_east])
    end
    it "returns an empty array when there is an empty search string" do
      result = Spot.search_by_name("")
      expect(result).to eq([])
    end
  end

  describe "reverse geolocation" do
    it "returns the saves correct address when latitude and longitude are saved" do
      spot = Fabricate(:spot, latitude: -41.313107, longitude: 174.828204)
      expect(spot.address).to include("215 Marine Parade")
    end
  end

  describe "#current_wind_speed" do
    it "returns a float" do
      spot = Fabricate(:spot, name: "The Ditch", latitude: -41.313107, longitude: 174.828204)
      result = spot.current_wind_speed
      expect(result).to be_a(Integer)
    end
  end

  describe "#current_wind_direction" do
    it "returns a string" do
      spot = Fabricate(:spot, name: "The Ditch", latitude: -41.313107, longitude: 174.828204)
      result = spot.current_wind_direction
      expect(result).to be_a(String)
    end
  end
end