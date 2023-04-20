class Friendship < ApplicationRecord
  # confirmed:boolean

  validates :user, presence: true
  validates :friend, presence: true

  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.confirmed?(id1, id2)
    case1 = !Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
    case2 = !Friendship.where(user_id: id2, friend_id: id1, confirmed: true).empty?
    case1 || case2
  end

  def self.locate_friendship(id1, id2)
    Friendship.find_by(user_id: id1, friend_id: id2) ||
      Friendship.find_by(user_id: id2, friend_id: id1)
  end

  def other_user(current_user)
    if user == current_user
      friend
    else
      user
    end
  end
end
