class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(comment_params)

  end

  private

  def comment_params
    params.require(:post).permit(:content)
  end

  def unauthorized
    flash[:alert] = 'You are not authorized to do that'
    redirect_to root_path
  end
end
