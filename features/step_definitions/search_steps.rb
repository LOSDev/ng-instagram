When(/^I search for a user$/) do
  @user = FactoryGirl.create(:user)
  visit root_path
  fill_in "search_query", with: @user.username
end

Then(/^I should see the username$/) do
  expect(page).to have_content(@user.username)
end

When(/^I select the username$/) do
  find("li a img.img-circle").click
end

Then(/^I should see the user's bio$/) do
  expect(page).to have_content @user.bio
end
