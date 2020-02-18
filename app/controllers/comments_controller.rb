class CommentsController < ApplicationController
  before_action :logged_in_user
  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html {redirect_to root_path }
        format.js{ render layout: false}
      end
    else
      redirect_to users_path
    end
  end
  
  def destroy
    @comment = @commentable.comments.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to root_path }
        format.js{ render layout: false}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end