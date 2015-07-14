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
end