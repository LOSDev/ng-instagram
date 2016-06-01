class AddFollowersCountToUsers < ActiveRecord::Migration
  def self.up
   add_column :users, :following_relationships_count, :integer, :default => 0
   add_column :users, :followed_relationships_count, :integer, :default => 0
   User.find_each { |user| User.reset_counters(user.id, :following_relationships) }
   User.find_each { |user| User.reset_counters(user.id, :followed_relationships) }
  end

  def self.down
   remove_column :users, :following_relationships_count
   remove_column :users, :followed_relationships_count

  end
end
