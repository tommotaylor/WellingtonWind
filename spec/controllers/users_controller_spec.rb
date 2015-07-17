require 'rails_helper'

describe UsersController do

  describe "GET new" do
    it "sets the @user variable if not signed in" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    it "redirects to the home path if already logged in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :new
      expect(response).to redirect_to(home_path)
    end
  end
  describe "POST create" do
    context "with valid inputs" do
      it "creates the user" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
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