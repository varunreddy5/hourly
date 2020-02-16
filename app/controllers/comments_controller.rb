class CommentsController < ApplicationController
  before_action :logged_in_user
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to root_path
    else
      redirect_to users_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end