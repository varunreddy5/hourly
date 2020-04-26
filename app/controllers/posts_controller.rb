class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :activity_feed, :index]
  def index
    @shared_posts = Post.where("original_tweet_id IS NOT NULL AND user_id = ?", current_user).pluck(:original_tweet_id)
    @pagy, @posts = pagy(Post.all.with_rich_text_content.includes(:comments, :likes, :user, user: :avatar_attachment).order(created_at: :desc).where.not(user_id: [current_user.following.pluck(:id).flatten << current_user.id]), items: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def activity_feed
    @shared_posts = Post.where("original_tweet_id IS NOT NULL AND user_id = ?", current_user).pluck(:original_tweet_id)
    @pagy, @posts = pagy(Post.all.with_rich_text_content.includes(:comments, :likes, :user, user: :avatar_attachment).where(user_id: [current_user.following.pluck(:id).flatten]).order(created_at: :desc), items: 10)
    respond_to do |format|
      format.html
      format.js
    end
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
    if @post.original_tweet_id
      @shared_post = Post.find(@post.original_tweet_id)
    end
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

  def share
    @post = Post.find(params[:id])
    @author = @post.user
    
    @shared_post = current_user.posts.new(post_params)
    @shared_post.original_tweet_id = @post.id
    if @shared_post.save
      respond_to do |format|
        format.html{ 
          flash[:success] = "Posted Shared Successfully!" 
          redirect_to current_user 
        }
        format.js
      end
    else
      redirect_to root_path
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:content)
  end
  
  
end
