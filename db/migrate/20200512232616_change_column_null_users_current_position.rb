class ChangeColumnNullUsersCurrentPosition < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :current_position, true, default: "Current position not updated"
  end
end
