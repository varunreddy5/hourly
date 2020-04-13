class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    
    ActionCable.server.broadcast "chatroom:#{message.chatroom.id}",
    {
      message: MessagesController.render(message),
      # message: ApplicationController.render(partial: message),
      chatroom_id: message.chatroom.id

    }
  end
end
