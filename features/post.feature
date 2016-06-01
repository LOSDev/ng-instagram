@javascript
Feature: Posts

  Scenario: Create a post
    Given I am a logged in user
    When I created a post
    And I enter a description
    Then I should see the description

  Scenario: Delete a posts
    Given I am a logged in user
    When I delete my post
    Then I should have 0 posts

  Scenario: Show post in a modal
    Given I am a guest
    When I visit a user
    And I click on one of his posts
    Then I should see the post in a modal

  Scenario: Paginate posts
    Given I am a guest
    When A User created 13 posts
    Then I should see 12 posts
    When I click "Load more"
    Then I should see 13 posts
