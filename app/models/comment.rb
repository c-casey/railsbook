class Comment < ApplicationRecord
  # content:string

  belongs_to :author, class_name: "User"
  belongs_to :parent, class_name: "Post"

  has_many :likes, foreign_key: "parent_id", dependent: :destroy

  def liked?(user)
    likes.exists?(author: user)
  end
end
