require 'elasticsearch/model'

class Post < ActiveRecord::Base
  include HashtagSearch

  mount_uploader :image, ImageUploader
  validates_presence_of :image
  belongs_to :user
  validates :user_id, presence: true
  has_many :comments
  has_many :likes
  validates :description, length: {maximum: 255}

  def next_id
    p = user.posts.where("id > ?", id).first
    return p.id if p
    nil
  end

  def previous_id
    p = user.posts.where("id < ?", id).last
    return p.id if p
    nil
  end

  validates_processing_of :image
  validate :image_size_validation


  private

  def image_size_validation
    errors[:image] << "should be less than 5MB" if image.size > 5.megabytes
  end


end

Post.import force: true
