class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  def new
    @like = Like.new
  end

  def create
    @likeable = find_likeable

    # return if Like.duplicate?(@post, current_user)

    @like = @likeable.likes.build(user: current_user)


    respond_to do |format|
      if @like.save
        format.turbo_stream { render turbo_stream: turbo_stream.update(@like.likeable) }
        format.html {
          redirect_to user_path(current_user),
          notice: "Post was successfully liked." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @likeable = find_likeable
    @like = Like.where(likeable: @likeable)
                .where(user: current_user).take

    @like.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update(@like.likeable) }
      format.html {
        redirect_to posts_url,
        notice: 'Post was successfully unliked.' }
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

  def find_likeable
    if params[:post_id]
      Post.find(params[:post_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    else
       render :new, status: :unprocessable_entity, notice: 'Invalid likeable object.'
    end
  end
end
