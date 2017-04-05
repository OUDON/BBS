require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns the topics to @topics in the correct order" do
      user = create(:user)
      first  = create(:topic, user: user, updated_at: 10.seconds.ago)
      second = create(:topic, user: user, updated_at: 1.minutes.ago)
      third  = create(:topic, user: user, updated_at: 10.minutes.ago)

      get :index
      expect(assigns(:topics)).to eq [first, second, third]
    end

    it "renders the :show index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    let!(:topic) { create(:topic) }

    it "assigns the requested topic to @topic" do
      get :show, params: { id: topic }
      expect(assigns(:topic)).to eq topic
    end

    it "renders the :show template" do
      get :show, params: { id: topic }
      expect(response).to render_template :show
    end
  end

  context "with logged in user" do
    before :each do
      @user = create(:user)
      set_user_session @user
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new topic in the database" do
          expect {
            post :create, params: { topic: attributes_for(:topic, user: @user) }
          }.to change(Topic, :count).by(1)
        end

        it "redirects to topics#show" do
          post :create, params: { topic: attributes_for(:topic, user: @user) }
          expect(response).to redirect_to(assigns[:topic])
        end
      end

      context "with invalid attributes" do
        it "does not save the new topic in the database" do
          expect {
            post :create, params: { topic: attributes_for(:invalid_topic) }
          }.not_to change(Topic, :count)
        end

        it "re-renders the :index template" do
          post :create, params: { topic: attributes_for(:invalid_topic) }
          expect(page).to render_template :index
        end
      end
    end
  end
end
