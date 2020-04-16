class DirectMessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @chatrooms = Chatroom.all
  end

  def show
    users = [current_user, User.find(params[:id])]
    @chatroom = Chatroom.direct_message_for_users(users)
    @messages = @chatroom.messages.order(created_at: :desc).reverse
    # render 'chatrooms/show'
  end
end