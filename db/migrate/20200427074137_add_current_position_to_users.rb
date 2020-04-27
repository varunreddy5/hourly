class AddCurrentPositionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :current_position, :string, null: false
  end
end
