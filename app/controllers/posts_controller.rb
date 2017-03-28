class PostsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @new_post = @topic.posts.new(post_params)
    @new_post.user = current_user

    if @new_post.save
      redirect_to @topic
    else
      render template: 'topics/show'
    end
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
