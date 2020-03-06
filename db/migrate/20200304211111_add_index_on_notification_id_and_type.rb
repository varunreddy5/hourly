class AddIndexOnNotificationIdAndType < ActiveRecord::Migration[6.0]
  def change
    add_index :notifications, [:notifiable_id, :notifiable_type]
  end
end
