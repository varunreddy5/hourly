class Posts::CommentsController < CommentsController
  before_action :logged_in_user
  before_action :set_commentable

  private 
  def set_commentable
    @commentable = Post.find(params[:post_id])
  end
end