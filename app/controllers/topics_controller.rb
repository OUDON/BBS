class TopicsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    @topics = Topic.ordered_by_updated_at
    @topic  = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    @user  = current_user
    @posts = @topic.posts.all
    @post  = Post.new
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      flash[:success] = "Your topic is created"
      redirect_to @topic
    else
      @topics = Topic.ordered_by_updated_at
      render action: :index
    end
  end

  def destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end
