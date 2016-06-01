class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true

  validates :user_id, presence: true
  validates :post_id, presence: true

  validates_uniqueness_of :post, scope: [:user]

  validate :not_liking_own_post

  private

  def not_liking_own_post
    return if post.blank?
    return if user.blank?

    errors.add(:base, "You can not like your own post.") if post.user.id == user_id
  end

end
