@javascript
Feature: Search

  Scenario: Search for users
    Given I am a guest
    When I search for a user
    Then I should see the username
    When I select the username
    Then I should see the user's bio
