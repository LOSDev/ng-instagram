When(/^I create a comment$/) do
  @post = FactoryGirl.create(:post, user: @user)
  visit "/#/posts/#{@post.id}"
  fill_in "comment_content", with: "first comment"
  click_on "submit_comment"
end

Then(/^I should see the comment$/) do
  expect(page).to have_content("first comment")
end

When(/^I create an invalid comment$/) do
  @post = FactoryGirl.create(:post, user: @user)
  visit "/#/posts/#{@post.id}"
  click_on "submit_comment"
end

Then(/^the comment should not be created$/) do
  expect(Comment.count).to eq 0
end

When(/^I delete the comment$/) do
  click_on "X"
end

Then(/^I should not see the comment$/) do
  expect(page).not_to have_content("first comment")
end

When(/^I see a comment from another user$/) do
  @other_user = FactoryGirl.create(:user)
  @post = FactoryGirl.create(:post, user: @user)
  Comment.create(content: "other user comment", post_id: @post.id, user_id: @other_user.id)
  visit "/#/posts/#{@post.id}"
end

Then(/^I should not see the delete link$/) do
  expect(page).not_to have_link("X")
end

When(/^I visit a post with (\d+) comments$/) do |arg1|
  @post = FactoryGirl.create(:post, user: @user)
  arg1.to_i.times do
    Comment.create(content: "a_comment", user_id: @user.id, post_id: @post.id)
  end
  visit "/#/posts/#{@post.id}"
end

Then(/^I should see (\d+) comments$/) do |arg1|
  expect(page).to have_content("a_comment", count: arg1.to_i)
end
