class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def new
    @friendship = Friendship.new
  end

  def create
    @friend = User.find(params[:id])
    @friendship = Friendship.new(user: current_user, friend: @friend)

    if @friendship.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end


  end


  private

  def friendship_params

  end
end
