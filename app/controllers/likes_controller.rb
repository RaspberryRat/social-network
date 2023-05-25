class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  def new
    @like = Like.new
  end

  def create
    set_post

    @like = Like.new(post: @post, user: current_user)
    respond_to do |format|
      if @like.save
        format.turbo_stream {
          render turbo_stream: turbo_stream.update(@post)
        }
        format.html {
          redirect_to user_path(current_user),
          notice: "Post was successfully liked." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    set_post
    @like = Like.where(post_id: @post)
                .where(user_id: current_user).take

    if current_user == @like.user
      @like.destroy
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.update(@post)
        }
        format.html {
          redirect_to posts_url,
          notice: 'Post was successfully unliked.' }
      end
    else
     unauthorized
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def unauthorized
    flash[:alert] = 'You are not authorized to do that'
    redirect_to root_path
  end
end
