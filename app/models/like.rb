class Like < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :author, uniqueness: { scope: :likeable }

  def self.lookup(user, post)
    Like.find_by!(author_id: user.id, likeable_id: post.id)
  end
end
