class TopicsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    @topics = Topic.ordered_by_updated_at
    @new_topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
    @new_post = Post.new
    @user = current_user
  end

  def create
    @new_topic = Topic.new(topic_params)
    @new_topic.user_id = current_user.id
    if @new_topic.save
      flash[:success] = "Your topic is created"
      redirect_to @new_topic
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
