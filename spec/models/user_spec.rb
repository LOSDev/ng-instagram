require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let(:post) {FactoryGirl.create(:post, user: user1)}



  it { should validate_length_of(:bio).is_at_most 255}
  it { should validate_length_of(:username).is_at_most 60}
  it { should validate_length_of(:username).is_at_least 2}
  it { should validate_uniqueness_of(:username)}
  it { should allow_value("user_name").for(:username) }
  it { should_not allow_value("user.name").for(:username) }
  it { should_not allow_value("user@name").for(:username) }


  it { should validate_presence_of(:avatar) }

  it { should have_many(:posts).dependent(:destroy)}
  it { should have_many(:comments).dependent(:destroy)}
  it { should have_many(:likes).dependent(:destroy)}
  it { should have_many(:liked_posts).through(:likes)}
  it { should have_many(:following_relationships).dependent(:destroy)}
  it { should have_many(:followers)}
  it { should have_many(:followed_relationships).dependent(:destroy)}
  it { should have_many(:followed_users)}

  describe '#feed' do
    describe 'user2 follows user1 and user3' do
      before do
        @user1 = FactoryGirl.create(:user)
        @user2 = FactoryGirl.create(:user)
        @user3 = FactoryGirl.create(:user)
        @post1 = FactoryGirl.create(:post, user: @user1)
        @post2 = FactoryGirl.create(:post, user: @user3)
        @user2.following_relationships.create(followed_id: @user1.id)
        @user2.following_relationships.create(followed_id: @user3.id)
      end
      it 'includes posts from user 1' do
        expect(@user2.feed).to include(@post1)
      end
      it 'does not include posts from user3' do
        expect(user2.feed).not_to include(@post2)
      end
    end
    describe 'user2 does not follow user1' do

    end
  end

  describe 'dependencies' do
    describe 'deleting a user' do
      before do
        @deleted_user = FactoryGirl.create(:user)
        post2 = FactoryGirl.create(:post, user: @deleted_user)
        comment = FactoryGirl.create(:comment, user_id: @deleted_user.id, post_id: post2.id)
        Like.create(user_id: @deleted_user.id, post_id: post.id)
        @deleted_user.following_relationships.create(followed_id: user2.id)
        @deleted_user.followed_relationships.create(follower_id: user2.id)
        User.find(@deleted_user.id).destroy
      end

      it 'deletes all his posts' do
        expect(Post.find_by(user_id: @deleted_user.id)).to eq nil
      end
      it 'deletes all his likes' do
        expect(Like.find_by(user_id: @deleted_user.id)).to eq nil
      end
      it 'deletes all his comments' do
        expect(Comment.find_by(user_id: @deleted_user.id)).to eq nil
      end
      it 'deletes all his following relationships' do
        expect(FollowingRelationship.find_by(follower_id: @deleted_user.id)).to eq nil
      end
      it 'deletes all his followed relationships' do
        expect(FollowingRelationship.find_by(followed_id: @deleted_user.id)).to eq nil

      end
    end
  end

end
