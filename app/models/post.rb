class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_rich_text :content
  validates :user_id, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, as: :commentable

  belongs_to :original_tweet, class_name: 'Post', optional: true

end
