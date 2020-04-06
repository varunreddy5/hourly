class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :activity_feed, :index]
  def index
    @pagy, @posts = pagy(Post.all.with_rich_text_content.includes(:comments, :likes, :user, user: :avatar_attachment).order(created_at: :desc).where.not(user_id: [current_user.following.pluck(:id).flatten << current_user.id]), items: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def activity_feed
    @pagy, @posts = pagy(Post.all.with_rich_text_content.includes(:comments, :likes, :user, user: :avatar_attachment).where(user_id: [current_user.following.pluck(:id).flatten << current_user.id]).order(created_at: :desc), items: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @posts = current_user.posts.build(post_params)
    @user = @posts.user
    respond_to do |format|
      if @posts.save
        @posts.user.followers.each do |user|
          Notification.create(recipient_id: user.id, user: current_user, action: "posted", notifiable: @posts)
        end
        format.html{ 
          flash[:success] = "Posted Successfully!" 
          redirect_to current_user 
        }
        format.js{ render layout: false}
      else
        format.html{ render current_user }
        format.js{ render layout: false}
      end
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
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
