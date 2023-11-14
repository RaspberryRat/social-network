class Users::FriendsController < ApplicationController
  before_action :authenticate_user!


  def index
    set_user
    @friends = @user.friends
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
