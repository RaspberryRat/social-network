class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def new
    @friendship = Friendship.new
  end

  def create
    @friend = User.find(params[:id])
    @friendship = current_user.friendships.build(@friend)
    @
  end


  private

  def friendship_params

  end
end
