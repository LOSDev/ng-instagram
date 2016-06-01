require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:post1) { FactoryGirl.create(:post, user: user) }
  let(:post2) { FactoryGirl.create(:post, user: user) }

  it { should validate_presence_of(:image) }


  it { should validate_presence_of(:user_id)}
  it { should validate_length_of(:description).is_at_most 255}
  it { should have_many(:comments)}
  it { should have_many(:likes)}

  describe 'next/previous' do
    before do
      @user = FactoryGirl.create(:user)
      @post1 = FactoryGirl.create(:post, user: @user)
      @post2 = FactoryGirl.create(:post, user: @user)
    end
    describe '#next' do
      it 'returns post 2' do
        expect(@post1.next_id).to eq @post2.id
      end
      it 'returns nil' do
        expect(@post2.next_id).to eq nil
      end
    end
    describe '#previous' do
      it 'returns post 1' do
        expect(@post2.previous_id).to eq @post1.id
      end
      it 'returns nil' do
        expect(@post1.previous_id).to eq nil
      end
    end
  end

end
