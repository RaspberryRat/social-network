class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    set_user
    @posts = @user.posts
  end

  def edit
    set_user
  end

  def update_profile_picture

    set_user
    @image = params[:user][:profile_picture]

    @user.profile_picture.attach(@image)
    redirect_to @user, notice: 'Profile picture updated successfully!'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
