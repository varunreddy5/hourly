class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatroom:#{chatroom.id}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  def send_message(data)
    @chatroom = Chatroom.find(data['chatroom_id'])
    @current_u = data['current_u']
    @users = @chatroom.chatroom_users.map(&:user_id)
    # @receiver = @users - [message.user]
    message = @chatroom.messages.create(body: data['body'], user: current_user)
    MessageRelayJob.perform_later(message, message.user.id, current_user)
  end
end
