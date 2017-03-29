class SearchController < ApplicationController
  def index
    @topics = Topic.search(params[:q]).order(updated_at: :desc)
    @query = params[:q]
  end
end
