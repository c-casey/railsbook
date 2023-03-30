class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :requested_friends, class_name: "Friendship"
  has_many :friend_requests, -> { where confirmed: false }, class_name: "Friendship", foreign_key: "friend_id"
  has_many :posts
  has_many :comments
  has_many :likes

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
end
