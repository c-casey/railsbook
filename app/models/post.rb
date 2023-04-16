class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :comments
  has_many :likes

  scope :ordered, -> { order(created_at: :desc) }

  def self.relevant(current_user)
    where(author: current_user.friends).or(where(author: current_user))
  end
end
