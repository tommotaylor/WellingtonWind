require 'rails_helper'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable if not signed in" do
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "redirects"
  end
  describe "POST create" do
    context "with valid inputs" do
      it "creates the user"
      it "sets the session"
      it "redirects to the home page"
    end
    context "with invalid inputs" do
      it "doesn't save the user"
      it "renders the register page"
      it "flashes an error"
    end
  end
end