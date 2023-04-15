class FriendRequestNotification < Notification
  validates :link, presence: true

  def self.discard_for(friendship)
    notification = find_by(link: friendship.id)
    notification&.destroy
  end

  def reference
    Friendship.find(link)
  end

  def to_partial_path
    "notifications/friend_request_notification"
  end
end
