class UsersController < ApplicationController
  # before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :index]

  def index
    @users = User.order(:created_at).paginate(page: params[:page])
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      remember @user 
      flash[:success] = "Welcome to hourly!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page])
    @post = @user.posts.build
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile Updated Successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    respond_to do |format|
      format.js
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.following
    
    respond_to do |format|
      format.js
    end
  end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path if @user != current_user
  end
end
