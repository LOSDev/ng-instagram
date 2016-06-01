When(/^I look at the feed$/) do
  visit root_path
  click_on @user.username
  click_on "Feed"
end

Then(/^I should see the posts of my friends$/) do
  expect(page).to have_content("Your feed")
  expect(page).to have_selector(".col-md-4 a img", count: 12)
end

Then(/^I should see more posts of my friends$/) do
  expect(page).to have_selector(".col-md-4 a img", count: 13)
end

When(/^I try to look at my feed$/) do
  visit "/#/users/feed"
end

Then(/^I should not see the feed page$/) do
  expect(page).not_to have_content("Your feed")
end

Given(/^I follow a user with (\d+) posts$/) do |arg1|
  @other_user = FactoryGirl.create(:user)
  arg1.to_i.times do
    FactoryGirl.create(:post, user: @other_user)
  end
  FollowingRelationship.create(follower_id: @user.id, followed_id: @other_user.id)
end
