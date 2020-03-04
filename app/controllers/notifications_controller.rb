class NotificationsController < ApplicationController
  before_action :logged_in_user
  def index
    @notifications = Notification.where(recipient_id: current_user.id).unread
  end

  def mark_as_read
    @notifications = Notification.where(recipient_id: current_user.id).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true}
  end
end
