  require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) {FactoryGirl.create(:user)}
  let(:user2) {FactoryGirl.create(:user)}
  let(:post) {FactoryGirl.create(:post, user: user)}

  it {should belong_to(:post)}
  it {should belong_to(:user)}

  it {should validate_presence_of(:post_id)}
  it {should validate_presence_of(:user_id)}


  describe 'liking posts' do
    describe 'with user and post' do
      it "saves the Like" do
        like = Like.create(user_id: user2.id, post_id: post.id)
        expect(like.valid?).to eq true
      end
    end

    describe 'liking a post twice' do
      it 'only creates 1 Like' do
        user2.likes.create(post_id: post.id)
        user2.likes.create(post_id: post.id)
        expect(Like.count).to eq 1
      end
    end
    describe 'liking your own post' do
      it 'is not valid' do
        like = Like.create(user: user, post: post)
        expect(like.valid?).to eq false
      end
    end
  end
end
