@javascript
Feature: User Pages

  Scenario: Create User
    Given I am a guest
    When I sign up for the website
    Then I have created a user account

  Scenario: Create invalid User
    Given I am a guest
    When I sign up for the website without a username
    Then I should see "is invalid"

  Scenario: Log out
    Given I am a logged in user
    When I Log out
    Then I should see "You are logged out now."

  Scenario: Edit User
    Given I am a logged in user
    When I change my username
    Then I should see the new username

  Scenario: Show User Profile
    Given I am a logged in user
    When I visit my Profile
    Then I should see my bio

  Scenario: Delete User
    Given I am a logged in user
    When I delete my Account
    Then I should see the home page
