require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context "guest access" do
    let!(:user) { create(:user) }

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders :new" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "authenticates the user" do
          post :create, params: { session: attributes_for(:user) }
          expect(controller.current_user).to eq user
        end

        it "redirects to root_path" do
          post :create, params: { session: attributes_for(:user) }
          expect(response).to redirect_to root_path
        end
      end
      
      context "with invalid attributes" do
        it "does not authenticate the user" do
          post :create, params: { session: attributes_for(:user, password: "wrong password") }
          expect(controller.current_user).not_to eq user
        end
          
        it "re-renders the :new template" do
          post :create, params: { session: attributes_for(:user, password: "wrong password") }
          expect(response).to render_template :new
        end
      end
    end
  end

  context "with logged in user" do
    before :each do
      user = create(:user)
      set_user_session user
    end

    it "GET #new denies access" do
      get :new
      expect(response).to redirect_to root_url
    end 

    it "POST #create denies access" do
      post :create, params: { session: attributes_for(:user, name: "andrew") }
      expect(response).to redirect_to root_url
    end
  end
end
