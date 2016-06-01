class RemoveAvatarFromUsers < ActiveRecord::Migration
  def self.up
    remove_attachment :users, :avatar   
  end

  def self.down
    remove_attachment :users, :avatar   
  end
end
