class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    set_user
    set_post

    @like = @

  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
