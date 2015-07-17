require 'rails_helper'

describe SessionsController do

  describe "GET new" do
    context "not signed in" do
      it "should render the new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "already signed in" do
      it "should redirect to the home page" do
        user = Fabricate(:user)
        session[:user_id] = user.id 
        get :new
        expect(response).to redirect_to home_path
      end
    end
  end
  
  describe "POST create" do
    context "with valid credentials" do
      it "sets the correct user id to the session" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(session[:user_id]).to eq(user.id)
      end
      it "redirects to home" do
        user = Fabricate(:user)
        post :create, email: user.email, password: user.password
        expect(response).to redirect_to home_path
      end
    end
    context "with invalid inputs" do
      it "doesn't set the session" do
        user = Fabricate(:user)
        post :create, email: user.email, password: "foo"
        expect(session[:user_id]).to eq(nil)
      end
      it "renders the login page" do
        user = Fabricate(:user)
        post :create, email: user.email, password: "foo"
        expect(response).to redirect_to sign_in_path
      end
      it "flashes an error" do
        user = Fabricate(:user)
        post :create, email: user.email, password: "foo"
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET destroy" do
    it "clears the session" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      get :destroy, user: user
      expect(session[:user_id]).to be_nil
    end
  end

end