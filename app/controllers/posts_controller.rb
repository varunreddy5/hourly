class PostsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html{ 
          flash[:success] = "Posted Successfully!" 
          redirect_to current_user 
        }
        format.js
      else
        format.html{ render current_user }
        format.js
      end
    end
  end

  def destroy
  
  end
  private
  def post_params
    params.require(:post).permit(:content)
  end
end
