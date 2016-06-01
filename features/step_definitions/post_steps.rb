When(/^I created a post$/) do
  post = FactoryGirl.create(:post, user: @user)
  visit "/#/posts/#{post.id}"
end

When(/^I enter a description$/) do
  fill_in "post_description", with: "my description"
  click_on "Change"
end

Then(/^I should see the description$/) do
  expect(page).to have_content("my description")
end

Then(/^I should be redirected to the new post$/) do
  expect(page).to have_selector(".col-md-8 img")
end


Then(/^I should still see the post form$/) do
  expect(page).to have_selector("#post_description")
end

When(/^I delete my post$/) do
  @post = FactoryGirl.create(:post, user: @user)
  visit "/#/posts/#{@post.id}"
  click_on "Delete"
end

Then(/^I should have (\d+) posts$/) do |arg1|
  expect(@user.posts.count).to eq arg1.to_i
end

When(/^I visit a user$/) do
  @user = FactoryGirl.create(:user)
  @post = FactoryGirl.create(:post, user: @user)
  visit "/#/users/#{@user.id}"
end

When(/^I click on one of his posts$/) do
  find("a img").click
end

Then(/^I should see the post in a modal$/) do
  expect(page).to have_selector(".modal .col-md-8 img")
end

When(/^A User created (\d+) posts$/) do |arg1|
  @user = FactoryGirl.create(:user)
  arg1.to_i.times do
    FactoryGirl.create(:post, user: @user)
  end
  visit "/#/users/#{@user.id}"
end

Then(/^I should see (\d+) posts$/) do |arg1|
  expect(page).to have_selector('.col-md-4 a img', count: arg1.to_i)
end

When(/^I click "([^"]*)"$/) do |arg1|
  click_on arg1
end
