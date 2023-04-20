module LikesHelper
  def like_button_text(post, user = current_user)
    verb = post.liked?(user) ? "Unlike" : "Like"
    "#{verb} (#{post.likes.count})"
  end

  def select_like_form(post, user = current_user)
    post.liked?(user) ? "likes/delete_form" : "likes/form"
  end

  def delete_like_path(post)
    like = find_like(post)
    like_path(like.id)
  end

  private

  def find_like(post, user = current_user)
    Like.lookup(user, post)
  end
end
