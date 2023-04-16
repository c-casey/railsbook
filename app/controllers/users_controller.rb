class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.locate_friendship(current_user.id, @user.id) || Friendship.new
    @posts = @user.posts.ordered
  end
end
