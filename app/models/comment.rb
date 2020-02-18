class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  validates :body, presence: true

  # Every comment should point to a particular post/commentable and also it should point to the parent
  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end
  
  
end
