class PostsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page])
  end

  def activity_feed
    
    @posts = Post.order(created_at: :desc).paginate(page: params[:page]).where(user_id: [current_user, current_user.following.pluck(:id)])
    render 'activity_feed'
  end

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
    @post = current_user.posts.find(params[:id])
    respond_to do |format|
      if @post.destroy
        format.html{ 
            flash[:success] = "Posted deleted Successfully!" 
            redirect_to current_user 
          }
        format.js{ render layout: false}
      else
        format.html{ redirect_to current_user }
        format.js
      end
    end
  end
  private
  def post_params
    params.require(:post).permit(:content)
  end
end
