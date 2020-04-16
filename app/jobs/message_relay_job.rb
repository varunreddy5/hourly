class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message, current_user_id)
    c_user = User.find(current_user_id)
    ActionCable.server.broadcast "chatroom:#{message.chatroom.id}",
    {
      message: MessagesController.render(message, locals: { incoming_message: message.user != c_user ? true : false }),
      chatroom_id: message.chatroom.id
    }
  end

  
end
