class UsersController < ApplicationController
  before_action :authenticate_user!
  

  def index
    debugger
    query = params[:q].presence || "*"
    @user = User.search(query, suggest: true)
  end
 

  def show
    @user = User.find_by_username(params[:id])
    @pagy, @posts =  pagy_countless(@user.posts.order(created_at: :desc), items: 20, link_extra: 'data-remote="true"')
    @post = @user.posts.build
    respond_to do |format|
      format.html
      format.js
    end
  end

 

  def followers
    @user  = User.find_by_username(params[:id])
    @users = @user.followers
    respond_to do |format|
      format.js
    end
  end

  def following
    @user  = User.find_by_username(params[:id])
    @users = @user.following
    
    respond_to do |format|
      format.js
    end
  end

  def autocomplete
    results = User.search(params[:term], {fields: [:username],match: :word_start,limit: 10, load: false,misspellings: {below: 5}}).map(&:username)
    # users = results.map{ |user| User.find_by_username(user)}
    render json: results
    
    # render json: User.search(params[:term], {fields: [:username],match: :word_start,limit: 10, load: false,misspellings: {below: 5}}).map(&:username)
  end

  
end
