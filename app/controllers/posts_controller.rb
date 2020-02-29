class PostsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :activity_feed, :index]
  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page]).where.not(user_id: [current_user.following.pluck(:id).flatten << current_user.id])
  end

  def activity_feed
    @posts = Post.where(user_id: [current_user.following.pluck(:id).flatten << current_user.id]).order(created_at: :desc).paginate(page: params[:page])
  end

  def create
    @post = current_user.posts.build(post_params)
    @user = @post.user
    respond_to do |format|
      if @post.save
        @post.user.followers.each do |user|
          Notification.create(recipient_id: user.id, user: current_user, action: "posted", notifiable: @post)
        end
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
