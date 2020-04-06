class AddIndexOnPostIdAndUserId < ActiveRecord::Migration[6.0]
  def change
    add_index :posts, [:original_tweet_id, :user_id]
  end
end
