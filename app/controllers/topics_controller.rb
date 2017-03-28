class TopicsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def index
    @topics = Topic.all
    @new_topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      flash[:success] = "Your topic is created"
      redirect_to @topic
    else
      render 'new'
    end
  end

  def destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:title)
  end
end
