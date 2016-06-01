When(/^I like a post$/) do
  @post = FactoryGirl.create(:post, user: FactoryGirl.create(:user))
  visit "/#/posts/#{@post.id}"
  click_on "post_like_button"

end

Then(/^The post should have one like$/) do
  expect(page).to have_content("1 likes")
end


When(/^I unlike a post$/) do
  click_on "post_unlike_button"
end

Then(/^the post should have (\d+) likes$/) do |arg1|
  expect(page).to have_content "#{arg1} likes"
end

When(/^I like (\d+) posts$/) do |arg1|
  arg1.to_i.times do
    post = FactoryGirl.create(:post, user: @user)
    @user.likes.create(post_id: post.id)
  end
end

When(/^I watch my liked posts$/) do
  click_on @user.username
  click_on "Liked Posts"
end
