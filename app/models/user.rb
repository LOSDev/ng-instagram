require 'elasticsearch/model'

class User < ActiveRecord::Base
  include UserSearch

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  extend FriendlyId
  friendly_id :username, use: :slugged

  def should_generate_new_friendly_id?
    username_changed?
  end

  mount_uploader :avatar, AvatarUploader
  validates_presence_of :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :username, length: {minimum: 2, maximum: 60}, uniqueness: true, format: { with: /\A[a-zA-Z0-9_-]+\Z/ }
  validates :bio, length: {maximum: 255}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :following_relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followed_users, through: :following_relationships, source: :followed

  has_many :followed_relationships, foreign_key: :followed_id, class_name: "FollowingRelationship", dependent: :destroy
  has_many :followers, through: :followed_relationships

  def feed
    following_ids = "SELECT followed_id FROM following_relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})", user_id: id)
  end

  validates_processing_of :avatar
  validate :avatar_size_validation




  private

  def avatar_size_validation
    errors[:avatar] << "should be less than 5MB" if avatar.size > 5.megabytes
  end


end
Article.import force: true
