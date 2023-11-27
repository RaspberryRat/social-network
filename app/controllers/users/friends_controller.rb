class Users::FriendsController < ApplicationController
  before_action :authenticate_user!


  def index
    set_user
    @friends = @user.friends
  end

  def destroy
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    @friendship = Friendship.find_by(user: @user, friend: @friend)

    if @user == current_user
      @friendship.friendship_over
      redirect_to users_user_friend_path(current_user)
    else
      flash[:error] = "You cannot remove other user's friends."
      redirect_to user_path(current_user)
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
