class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @discussion = Discussion.find(params[:discussion_id])
    @post.discussion = @discussion

    if @post.save
      @discussion.update(updated_at: Time.now)
    else
      flash[:notice] = "Post creation failed"
    end

    redirect_to discussion_path(@discussion, anchor: "post-#{@post.id}")
  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
