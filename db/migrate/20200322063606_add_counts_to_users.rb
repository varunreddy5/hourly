class AddCountsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :posts_count, :integer, default: 0, null: false
    add_column :users, :followers_count, :integer, default: 0, null: false
    add_column :users, :following_count, :integer, default: 0, null: false
    reversible do |dir|
      dir.up { data }
    end
  end
  def data
    execute <<-SQL.squish
      UPDATE USERS
        SET posts_count = (SELECT count(1)
                                FROM posts 
                                WHERE posts.user_id = users.id),
            followers_count = (SELECT count(1)
                              FROM relationships
                              WHERE relationships.followed_id = users.id),
            following_count = (SELECT count(1)
                                FROM relationships
                                WHERE relationships.follower_id = users.id)
    SQL
  end
end
