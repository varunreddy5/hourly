class UsersController < ApplicationController
  # before_action :logged_in_user
  # before_action :correct_user, only: [:edit, :update, :index]

  # def index
  #   @pagy, @users = pagy_countless(User.all.order(:created_at), link_extra: 'data-remote="true"')
  # end
  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     log_in @user
  #     remember @user 
  #     flash[:success] = "Welcome to hourly!"
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end

  def show
    @user = User.find(params[:id])
    @pagy, @posts =  pagy_countless(@user.posts.order(created_at: :desc), items: 20, link_extra: 'data-remote="true"')
    @post = @user.posts.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  # def edit
  #   @user = User.find(params[:id])
    
  # end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update_attributes(user_params)
  #     flash[:success] = 'Profile Updated Successfully'
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end

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

  # private 
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

  

  # def correct_user
  #   @user = User.find(params[:id])
  #   redirect_to root_path if @user != current_user
  # end
end
