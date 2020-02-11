module PostsHelper
  def already_liked?(post, user)
    post.likes.where(user: user).any?
  end 
end
