class CommentsController < ApplicationController
  def new
    set_post
    set_user

    @comment = Comment.new
  end

  def create
    set_post
    @comment = Comment.new(
      comment_params.merge(post: @post, author: current_user)
    )

    respond_to do |format|
      if @comment.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.append(@post, @comment)
        }
        format.html {
          redirect_to user_path(@post.author),
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

    respond_to do |format|
      if @comment.update(comment_params)
        format.html {
          redirect_to user_path(@comment.post.author),
          notice: "Comment was successfully updated." }
        # format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
    @comment = Comment.find(params[:id])
  end

end
