class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message, message_user, current_user)
    # debugger
    puts message_user, current_user
    ActionCable.server.broadcast "chatroom:#{message.chatroom.id}",
    {
      message: MessagesController.render(message, locals: { incoming_message: message_user == current_user ? false : true }),
      chatroom_id: message.chatroom.id
    }
  end

  
end
