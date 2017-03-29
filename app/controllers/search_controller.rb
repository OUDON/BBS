class SearchController < ApplicationController
  def index
    @topics = Topic.search(params[:q])
    @query = params[:q]
  end
end
