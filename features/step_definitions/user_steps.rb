When(/^I sign up for the website$/) do
  visit root_path
  @user = FactoryGirl.build(:user)
  click_on "Register"
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  fill_in "user_password_confirmation", with: @user.password
  fill_in "user_bio", with: @user.bio
  fill_in "user_username", with: @user.username

  attach_file "user_avatar", File.join(Rails.root, '/app/assets/images/image_12.jpeg')
  click_button "Create Account"
end

Then(/^I have created a user account$/) do
  expect(page).to have_content(@user.bio)
  expect(page).to have_content(@user.username)
  expect(page).to have_content("0 posts")
  expect(page).to have_selector(".col-md-4 img")
end

When(/^I sign up for the website without a username$/) do
  visit root_path
  @user = FactoryGirl.build(:user)
  click_on "Register"
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  fill_in "user_password_confirmation", with: @user.password
  fill_in "user_bio", with: @user.bio
  fill_in "user_username", with: ""

  attach_file "user_avatar", File.join(Rails.root, '/app/assets/images/image_12.jpeg')

  click_button "Create Account"
end


Given(/^I am a logged in user$/) do
  @user = FactoryGirl.create(:user)
  visit root_path
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  click_on "user_log_in"
end

When(/^I Log out$/) do
  click_on @user.username
  click_on "Log out"
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end

When(/^I change my username$/) do
  click_on @user.username
  click_on "Account Settings"
  fill_in "user_username", with: "new_username"
  fill_in "user_current_password", with: @user.password
  click_on "Update Account"
end

Then(/^I should see the new username$/) do
  expect(page).to have_content "new_username"
end

When(/^I visit my Profile$/) do
  click_on @user.username
  click_on "My Profile"
end

Then(/^I should see my bio$/) do
  expect(page).to have_content @user.bio
end

When(/^I delete my Account$/) do
  click_on @user.username
  click_on "Account Settings"
  click_on "Delete Account"
end

Then(/^I should see the home page$/) do
  expect(page).to have_content("Welcome to ng-Instagram")
end
