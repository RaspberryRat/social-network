class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @friendship = Friendship.new
  end

  def create
    @friend = User.find(params[:id])
    @friendship = Friendship.new(user: current_user, friend: @friend)

    if @friendship.save
      redirect_to user_path(@friend)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @user = User.find(params[:user_id])
    @friend_requests = Friendship.show_friend_requests(@user.id)
  end

  def update
    @friend_request = Friendship.find(params[:id])
    @user = @friend_request.friend

    @friend_request.confirm_friend
    redirect_to user_path(@user)
  end

  def destroy
    @friend_request = Friendship.find(params[:id])
    @user = @friend_request.friend

    @friend_request.destroy
    redirect_to user_path(@user)
  end


  private

  def friendship_params

  end
end
