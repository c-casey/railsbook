class FriendshipsController < ApplicationController
  def index
    @friendships = current_user.friends
  end

  def create
    @friendship = current_user.requested_friends.new(friendship_params)

    if @friendship.save
      @user = @friendship.friend
      FriendRequestNotification.create(sender: current_user,
                                       receiver: @friendship.friend,
                                       link: @friendship.id)
      redirect_to @user
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    redirect_link = user_path(@friendship.other_user(current_user))

    @friendship.update(confirmed: true) if @friendship.friend == current_user

    FriendRequestNotification.discard_for(@friendship)
    redirect_to redirect_link
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    redirect_link = user_path(@friendship.other_user(current_user))

    @friendship.destroy

    FriendRequestNotification.discard_for(@friendship)
    redirect_to redirect_link
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id)
  end
end
