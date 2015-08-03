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
        favourite = Fabricate(:favourite, user_id: user.id)
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

  describe "POST create" do
    context "signed in" do
      before do
        set_user
      end
      it "redirects to favourites path" do
        spot = Fabricate(:spot)
        post :create, spot_id: spot.id 
        expect(response).to redirect_to favourites_path
      end
      it "creates the favourite associated with the current user" do
        spot = Fabricate(:spot)
        post :create, spot_id: spot.id
        expect(Favourite.first.user_id).to eq(session[:user_id])
      end
      it "creates the favourite associated with the correct spot" do
        spot = Fabricate(:spot)
        post :create, spot_id: spot.id
        expect(Favourite.first.spot_id).to eq(spot.id)
      end
      it "adds the favourite as the last item in the list" do
        spot1 = Fabricate(:spot)
        spot2 = Fabricate(:spot)
        favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
        post :create, spot_id: spot2.id, user_id: session[:user_id]
        expect(Favourite.second.list_order).to eq(2)
      end
      it "doesn't add the favourite if it is already a favourite" do
        spot1 = Fabricate(:spot)
        Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id])
        post :create, spot_id: spot1.id
        expect(Favourite.count).to eq(1)
      end
    end
    context "not signed in" do
      it "redirects to the sign in page" do
        spot = Fabricate(:spot)
        post :create, spot_id: spot.id 
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "POST update" do
    context "signed in" do
      before do
        set_user
      end
      context "with valid inputs" do
        it "updates the list order" do
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: session[:user_id], list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: 2}, {id: favourite2.id, list_order: 1}]
          expect(favourite2.reload.list_order).to eq(1)
        end
        it "normalises the queue" do
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: session[:user_id], list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: 6}, {id: favourite2.id, list_order: 1}]
          expect(favourite1.reload.list_order).to eq(2)
        end
        it "doesn't update the queue if the favourite isn't in the current users queue" do
          user2 = Fabricate(:user)
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: user2.id, list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: 2}, {id: favourite2.id, list_order: 1}]
          expect(favourite2.reload.list_order).to eq(2)
        end
      end
      context "with invalid inputs" do
        it "doesnt update if input is a float" do
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: session[:user_id], list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: 6.56 }, {id: favourite2.id, list_order: 2}]
          expect(favourite1.reload.list_order).to eq(1)
        end
        it "doesn't update if input is a string" do
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: session[:user_id], list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: "foobar"}, {id: favourite2.id, list_order: 2}]
          expect(favourite1.reload.list_order).to eq(1)
        end
        it "doesn't save the first favourite if there is an error with second or subsequent favourites" do
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: session[:user_id], list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: 3}, {id: favourite2.id, list_order: "foobar"}]
          expect(favourite1.reload.list_order).to eq(1)
        end
        it "flashes an error message" do
          spot1 = Fabricate(:spot)
          spot2 = Fabricate(:spot)
          favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: session[:user_id], list_order: 1)
          favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: session[:user_id], list_order: 2)
          post :update_favourites, favourites: [{id: favourite1.id, list_order: "foobar"}, {id: favourite2.id, list_order: 2}]
          expect(flash[:error]).to be_present
        end
      end
    end
    context "not signed in" do
      it "does not upate the queue" do
        spot1 = Fabricate(:spot)
        spot2 = Fabricate(:spot)
        favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: 1, list_order: 1)
        favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: 1, list_order: 2)
        post :update_favourites, favourites: [{id: favourite1.id, list_order: 2}, {id: favourite2.id, list_order: 1}]
        expect(favourite1.list_order).to eq(1)
      end
      it "redirects to login page" do
        spot1 = Fabricate(:spot)
        spot2 = Fabricate(:spot)
        favourite1 = Fabricate(:favourite, spot_id: spot1.id, user_id: 1, list_order: 1)
        favourite2 = Fabricate(:favourite, spot_id: spot2.id, user_id: 1, list_order: 2)
        post :update_favourites, favourites: [{id: favourite1.id, list_order: 2}, {id: favourite2.id, list_order: 1}]
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "DELETE destroy" do
    before do
        set_user
      end
    it "deletes the favourite" do
      spot = Fabricate(:spot)
      favourite = Fabricate(:favourite, spot_id: spot.id, user_id: session[:user_id], list_order: 1)
      delete :destroy, id: favourite.id
      expect(Favourite.count).to eq(0)
    end
    it "doesn't delete the favourite if it isn't in the users queue" do
      user2 = Fabricate(:user)
      spot = Fabricate(:spot)
      favourite = Fabricate(:favourite, spot_id: spot.id, user_id: user2.id, list_order: 1)
      delete :destroy, id: favourite.id
      expect(Favourite.count).to eq(1)
    end
    it "redirects to the favourites page" do
      spot = Fabricate(:spot)
      favourite = Fabricate(:favourite, spot_id: spot.id, user_id: session[:user_id], list_order: 1)
      delete :destroy, id: favourite.id
      expect(response).to redirect_to favourites_path
    end
  end
end