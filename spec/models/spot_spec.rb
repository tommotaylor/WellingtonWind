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
end