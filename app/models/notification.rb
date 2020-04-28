class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User", dependent: :destroy
  belongs_to :notifiable, polymorphic: true

  scope :unread, ->{ where(read_at: nil) }
  scope :recent, ->{ order(created_at: :desc).limit(5)}
  after_commit -> {NotificationRelayJob.perform_later(self)}
end
