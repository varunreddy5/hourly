class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatroom:#{message.chatroom.id}",
    {
      message: MessagesController.render(message),
      # message: render_comment,
      # message: ApplicationController.render(partial: message),
      chatroom_id: message.chatroom.id
    }
  end

  
end
