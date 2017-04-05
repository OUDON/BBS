class PostsController < ApplicationController
  before_action :logged_in_user

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:success] = "Your post is created"
      redirect_to @topic
    else
      @posts = @topic.posts.all
      render template: 'topics/show'
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
