class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true


  validates :content, length: {minimum: 1, maximum: 255}
  validates :user, presence: true
  validates :post, presence: true

end
