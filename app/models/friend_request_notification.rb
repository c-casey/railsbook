class FriendRequestNotification < Notification
  def self.create_and_send(friendship)
    super(sender: friendship.user,
          receiver: friendship.friend,
          link: friendship.id,
          type: self)
  end

  def to_partial_path
    "notifications/friend_request_notification"
  end
end
