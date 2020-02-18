module PostsHelper
  include SessionsHelper
  def already_liked?(post, user)
    post.likes.where(user: user).any?
  end 
  def current_user_post?(post)
    # you can't use find since you can't chain any on it
    current_user.posts.where(id: post.id).any?
  end
end
