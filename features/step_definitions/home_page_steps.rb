Given(/^I am a guest$/) do
end

When(/^I visit the homepage$/) do
  visit root_path
end

Then(/^I should see the logo$/) do
  expect(page).to have_selector(".navbar-brand", text: "ng-Instagram")
end

Then(/^I should see a Register link$/) do
  expect(page).to have_link("Register")
end
