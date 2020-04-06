class AddOriginalTweetIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :original_tweet_id, :integer
  end
end
