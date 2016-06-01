When(/^I follow another user$/) do
  @other_user = FactoryGirl.create(:user)
  visit "/#/users/#{@other_user.id}"
  click_on "Follow"
end

Then(/^another user has (\d+) follower$/) do |arg1|
  expect(page).to have_content "1 follower"
end

Then(/^I am following (\d+) user$/) do |arg1|
  visit "/#/users/#{@user.id}"
  expect(page).to have_content "1 following"
end

When(/^I unfollow him$/) do
  click_on "Following"
end

Then(/^another user has (\d+) followers$/) do |arg1|
  expect(page).to have_content("#{arg1} followers")
end

Then(/^I am following (\d+) users$/) do |arg1|
  expect(page).to have_content("#{arg1} following")
end

When(/^I look at the users I follow$/) do
  visit "/#/users/#{@user.id}"
  click_on "1 following"
end

When(/^another user follows me$/) do
  @other_user = FactoryGirl.create(:user)
  FollowingRelationship.create(follower_id: @other_user.id, followed_id: @user.id)
end

When(/^I look at my followers$/) do
  visit "/#/users/#{@user.id}/followers"
end

When(/^(\d+) users follow me$/) do |arg1|
  arg1.to_i.times do
    user = FactoryGirl.create(:user)
    FollowingRelationship.create(follower_id: user.id, followed_id: @user.id)
  end
end

Then(/^I should see (\d+) followers$/) do |arg1|
  expect(page).to have_selector(".list-group-item", count: arg1.to_i)
end

When(/^I follow (\d+) users$/) do |arg1|
  arg1.to_i.times do
    user = FactoryGirl.create(:user)
    FollowingRelationship.create(follower_id: @user.id, followed_id: user.id)
  end
end

Then(/^I should see the other user's bio$/) do
  expect(page).to have_content(@other_user.bio)
end

Then(/^I should see (\d+) followed users$/) do |arg1|
  expect(page).to have_selector(".list-group-item", count: arg1.to_i)
end
