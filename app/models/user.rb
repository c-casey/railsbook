class User < ApplicationRecord
  # email:string, name:string

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :requested_friends, class_name: "Friendship"
  has_many :friend_requests, -> { where confirmed: false }, class_name: "Friendship", foreign_key: "friend_id"
  has_many :posts, foreign_key: "author_id"
  has_many :comments, foreign_key: "author_id"
  has_many :likes, foreign_key: "author_id"
  has_many :sent_notifications, class_name: "Notification", foreign_key: "sender_id"
  has_many :received_notifications, class_name: "Notification", foreign_key: "receiver_id"

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    return user if user

    User.create(name: data["name"],
                email: data["email"],
                password: Devise.friendly_token[0,20])
  end

  def friends
    friend_requesters = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    friend_requestees = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    friend_ids = friend_requesters + friend_requestees
    User.where(id: friend_ids)
  end

  def friends_with?(user)
    Friendship.confirmed?(id, user.id)
  end

  def request_friendship(user)
    requested_friends.create(friend_id: user.id)
  end

  def accept_friendship(friend_request)
    friend_request.confirm
  end
end
