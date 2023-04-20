module CommentsHelper
  def comments_button_text(post)
    "Comments (#{post.comments.count})"
  end
end
