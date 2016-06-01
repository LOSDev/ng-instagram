class RemoveImageFromPosts < ActiveRecord::Migration
  def self.up
    remove_attachment :posts, :image
  end

  def self.down
    remove_attachment :posts, :image
  end
end
