class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.append('posts', @post)
        }
        format.html {
          redirect_to user_path(current_user),
          notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
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
