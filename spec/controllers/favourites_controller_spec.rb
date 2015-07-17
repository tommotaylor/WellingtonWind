require 'rails_helper'

describe FavouritesController do

  describe "GET index" do
  
    context "signed in" do
      it "renders the index page" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        get :index
        expect(response).to render_template :index
      end

      it "sets the @favourites variable" do
        user = Fabricate(:user)
        session[:user_id] = user.id
        favourite = Fabricate(:favourite)
        get :index
        expect(assigns(:favourites)).to eq([favourite])
      end
    end

    context "not signed in" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end