class AddLikesAndCommentsCountToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :likes_count, :integer, default: 0, null: false
    add_column :posts, :comments_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE POSTS
        SET likes_count = (SELECT count(1)
                                FROM likes 
                                WHERE likes.post_id = posts.id),
            comments_count = (SELECT count(1)
                                    FROM comments
                                    WHERE comments.commentable_id = posts.id AND comments.commentable_type = 'Post')
    SQL
  end
end
