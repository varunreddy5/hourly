class Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_rich_text :content
  # validates :content, presence: true
  validates :user_id, presence: true
  has_many :likes, dependent: :destroy
  has_many :comments, as: :commentable

end
