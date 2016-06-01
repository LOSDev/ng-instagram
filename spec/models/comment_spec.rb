require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user)}
  it { should belong_to(:post)}
  it { should validate_presence_of(:post)}
  it { should validate_presence_of(:user)}
  it { should validate_length_of(:content).is_at_least 1}
  it { should validate_length_of(:content).is_at_most 255}



end
