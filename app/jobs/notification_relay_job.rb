class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = ApplicationController.render partial:'notifications/posts/posted', locals: {notification: notification }, format: [:html]
    ActionCable.server.broadcast "notifications:#{notification.recipient_id}", html: html
    
  end
end
