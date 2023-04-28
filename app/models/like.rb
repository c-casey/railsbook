class Like < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :author, uniqueness: { scope: :parent }

  def self.lookup(user, post)
    Like.find_by!(author_id: user.id, parent_id: post.id)
  end
end
