When(/^I visit a post$/) do
  @post = FactoryGirl.create(:post, description: "#dogs", user: FactoryGirl.create(:user))
  visit "/#/posts/#{@post.id}"
end

When(/^I click on a hashtag$/) do
  click_on "#dogs"
end

Then(/^I should see all posts with the hashtag$/) do
  expect(page).to have_selector(".col-md-4 a img")
end

When(/^there are (\d+) posts with a hashtag$/) do |arg1|
  @user = FactoryGirl.create(:user)
  arg1.to_i.times do
    @post = FactoryGirl.create(:post, description: "#dogs", user: @user)
  end
end

When(/^I visit the hashtag path$/) do
  visit "/#/posts/#{Post.last.id}"
  click_on "#dogs"
end
