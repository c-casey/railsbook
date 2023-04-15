class NotificationsController < ApplicationController
  def index
    @notifications = current_user.received_notifications
  end

  # def destroy
  #   @notification = Notification.find(params[:id])
  #   @notification.destroy

  #   redirect_to notifications_path, status: :see_other
  # end
end
