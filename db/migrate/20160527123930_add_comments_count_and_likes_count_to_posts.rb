class AddCommentsCountAndLikesCountToPosts < ActiveRecord::Migration
  def self.up
   add_column :posts, :comments_count, :integer, :default => 0
   add_column :posts, :likes_count, :integer, :default => 0
   Post.find_each { |post| Post.reset_counters(post.id, :comments) }
   Post.find_each { |post| Post.reset_counters(post.id, :likes) }
  end

  def self.down
   remove_column :posts, :comments_count
   remove_column :posts, :likes_count

  end
end
