require 'digest'

module UsersHelper
  def avatar_url(user:, size: 64)
    email = user.email.strip.downcase
    md5 = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{md5}?d=mp&s=#{size}"
  end

  def locate_friendship(user)
    Friendship.locate_friendship(current_user, user) || Friendship.new
  end
end
