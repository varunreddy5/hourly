class MessagesController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  def self.render_with_signed_in_user(user, *args)
    ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
    proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
    renderer = self.renderer.new('warden' => proxy)
    renderer.render(*args)
  end
  # before_action :set_chatroom

  # def create
  #   message = @chatroom.messages.new(message_params)
  #   message.user = current_user
  #   message.save
  #   MessageRelayJob.perform_later(message)
  # end

  # def destroy
  
  # end
  # private
  # def set_chatroom
  #   @chatroom = Chatroom.find(params[:chatroom_id])
  # end

  # def message_params
  #   params.require(:message).permit(:body)
  # end
end