class SearchController < ApplicationController
  def index
    @topics = Topic.search(params[:q])
  end
end
