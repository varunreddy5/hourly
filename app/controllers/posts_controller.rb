class PostsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :activity_feed, :index]
  def index
    @count  = 1
    # @posts = Post.order(created_at: :desc).paginate(page: params[:page]).where.not(user_id: [current_user.following.pluck(:id).flatten << current_user.id])
    @pagy, @posts = pagy_countless(Post.all.order(created_at: :desc).where.not(user_id: [current_user.following.pluck(:id).flatten << current_user.id]), items: 20, link_extra: 'data-remote="true"')
    # pagy_countless(Product.all, link_extra: 'data-remote="true"'
    respond_to do |format|
      format.html
      format.js
    end

  end

  def activity_feed
    @pagy, @posts = pagy_countless(Post.all.where(user_id: [current_user.following.pluck(:id).flatten << current_user.id]).order(created_at: :desc), items: 20,link_extra: 'data-remote="true"')
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
