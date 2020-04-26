class User < ApplicationRecord
  include ActionText::Attachable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  before_save { self.email = email.downcase}
  validates_presence_of :username
  validates_uniqueness_of :username
  has_one_attached :avatar
 
  has_many :active_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services
  searchkick word_start: [:username]

  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages, dependent: :destroy
  
  def to_trix_content_attachment_partial_path
    to_partial_path
  end
  
  def to_param
    username
  end
  
  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
