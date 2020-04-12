class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to chatrooms_path
    else
      redirect_to root_path
    end
  end

  def index
    @chatrooms = Chatroom.all
  end

  def show
  end

  def destroy
    @chatroom = Chatroom.find(params[:chatroom_id])
    if @chatroom.destroy
      redirect_to chatrooms_path
    else
      redirect_to root_path
    end
  end

  private
  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end