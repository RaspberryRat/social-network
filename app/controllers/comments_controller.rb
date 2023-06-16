class CommentsController < ApplicationController
  def new
    set_post
    set_user

    @comment = Comment.new
  end

  def create
    debugger
    set_commentable

    @comment = Comment.new(
      comment_params.merge(commentable: @commentable, author: current_user)
    )
    @comment.parent_id = @parent&.id

    respond_to do |format|
      if @comment.save
        if @parent
          format.turbo_stream {
            render turbo_stream: turbo_stream.append(@parent, @comment)
          }
        else
          format.turbo_stream {
            render turbo_stream: turbo_stream.append("comment_#{@commentable.id}", @comment)
          }
        end
        format.html {
          redirect_to user_path(@commentable.author),
          notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def index
    set_post
    @comments = Comment.show_comments(@post)
  end

  def show
    set_comment
  end

  def edit
    set_comment
  end

  def update
    set_comment

    return unauthorized unless current_user == @comment.author

    respond_to do |format|
      if @comment.update(comment_params)
        format.html {
          redirect_to user_path(@comment.commentable.author),
          notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_comment

    return unauthorized unless current_user == @comment.author

    @comment.destroy
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: turbo_stream.remove(@comment)
      }
      format.html {
        redirect_to posts_url,
        notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def unauthorized
    flash[:alert] = 'You are not authorized to do that'
    redirect_to root_path
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_comment
    return @comment = Comment.find(params[:comment_id]) if params[:comment_id]

    @comment = Comment.find(params[:id])
  end

  def set_commentable
    if params[:comment_id]
      set_parent
      @commentable = @parent.commentable
    elsif params[:post_id]
      @commentable = set_post
    end
  end

  def set_parent
    @parent = Comment.find(params[:comment_id])
  end
end
