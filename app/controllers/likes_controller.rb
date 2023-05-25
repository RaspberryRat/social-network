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

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
