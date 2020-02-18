class LikesController < ApplicationController
  before_action :logged_in_user
  before_action :find_post
  def create
    @like = @post.likes.build(user: current_user)
    
      if @like.save
        respond_to do |format|
        format.html{
          redirect_to root_path
        }
          format.js
        end
      else
        respond_to do |format|
          format.html{ render current_user}
          format.js{ render layout: false}
        end
      end
  end

  def destroy
    @post.likes.where(user: current_user).destroy_all
    respond_to do |format|
      format.html{
        redirect_to root_path
      }
      format.js{ render layout: false}
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
