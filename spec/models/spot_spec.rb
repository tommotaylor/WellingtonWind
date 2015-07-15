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

  describe "reverse geoclation" do
    it "returns the saves correct address when latitude and longitude are saved" do
      spot = Fabricate(:spot, latitude: -41.313107, longitude: 174.828204)
      expect(spot.address).to eq("215 Marine Parade, Seatoun, Wellington 6022, New Zealand")
    end
  end
end