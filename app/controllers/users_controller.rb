class UsersController < ApplicationController
  before_action :validate_current_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @friendship = Friendship.locate_friendship(current_user.id, @user.id) || Friendship.new
    @posts = @user.posts.ordered.includes(:author)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def validate_current_user
    return if User.find(params[:id]) == current_user

    redirect_to user_path(params[:id]), status: :forbidden
  end

  def user_params
    params.require(:user).permit(:name, :bio)
  end
end
