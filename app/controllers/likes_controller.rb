class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  def new
    @like = Like.new
  end

  def create
    set_post

    @like = @post.likes.new(user: current_user)

    respond_to do |format|
      if @like.save
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
    @post = Post.find(params[:id])
  end
end
