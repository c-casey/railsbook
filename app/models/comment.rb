class Comment < ApplicationRecord
  # content:string

  belongs_to :author, class_name: "User"
  belongs_to :parent, class_name: "Post"

  has_many :likes, as: :likeable, foreign_key: "likeable_id", dependent: :destroy

  scope :ordered, -> { order(created_at: :desc) }

  def liked?(user)
    likes.exists?(author: user)
  end
end
