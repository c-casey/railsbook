class FriendRequestNotification < Notification
  def self.create_and_send(sender:, receiver:, link:, type: self)
    super
  end
end
