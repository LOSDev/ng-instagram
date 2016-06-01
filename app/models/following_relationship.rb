class FollowingRelationship < ActiveRecord::Base

  belongs_to :follower, class_name: "User", counter_cache: :following_relationships_count
  belongs_to :followed, class_name: "User", counter_cache: :followed_relationships_count

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates_uniqueness_of :followed_id, scope: :follower_id, message: "this user already."

  validate :dont_follow_self

  private

  def dont_follow_self
    errors.add(:base, 'You can\'t follow yourself.') if followed_id == follower_id
  end
end
