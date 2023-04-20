class Post < ApplicationRecord
  # content:string

  belongs_to :author, class_name: "User"

  has_many :comments, foreign_key: "parent_id", dependent: :destroy
  has_many :likes, foreign_key: "parent_id", dependent: :destroy

  scope :ordered, -> { order(created_at: :desc) }

  def self.relevant(current_user)
    where(author: current_user.friends).or(where(author: current_user))
  end

  def liked?(user)
    likes.exists?(author: user)
  end
end
