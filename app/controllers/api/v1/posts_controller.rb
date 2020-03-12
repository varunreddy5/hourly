class Api::V1::PostsController < ApiController
  before_action :set_user
  
  def show
    
  end
  def index
    @posts = @user.posts
  end

  def set_user
    @user = User.find_by_username(params[:user_id])
  end
end