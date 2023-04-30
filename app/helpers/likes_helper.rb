module LikesHelper
  def like_button_text(likeable, user = current_user)
    verb = likeable.liked?(user) ? "Unlike" : "Like"
    "#{verb} (#{likeable.likes.count})"
  end

  def select_like_form(likeable, user = current_user)
    likeable.liked?(user) ? "likes/delete_form" : "likes/form"
  end

  def delete_like_path(likeable)
    like = find_like(likeable)
    like_path(like.id)
  end

  private

  def find_like(likeable, user = current_user)
    Like.lookup(user, likeable)
  end
end
