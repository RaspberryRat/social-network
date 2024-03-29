class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])

    if @friendship.save
      @friend = @friendship.friend
      redirect_to user_path(@friend)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @user = User.find(params[:user_id])
    if current_user == @user
      @friend_requests = Friendship.show_friend_requests(@user.id)
    else
      flash[:alert] = 'You are not authorized to access this page'
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def update
    @friend_request = Friendship.find(params[:id])
    @user = @friend_request.friend
    if @user == current_user
      @friend_request.confirm_friend
      redirect_to user_path(@user)
    else
      flash[:error] = "You can only accept friend requests sent to you."
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @friend_request = Friendship.find(params[:id])
    @user = @friend_request.friend

    @friend_request.destroy
    redirect_to user_path(@user)
  end

  private
  # TODO can't get this working
  # def friendship_params
  #   debugger
  #   params.require(:friendship).permit(:user_id, :friend_id)
  # end
end
