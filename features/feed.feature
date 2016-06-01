@javascript
Feature: Feed

  Scenario: Looking at posts of users you follow
    Given I am a logged in user
    And I follow a user with 13 posts
    When I look at the feed
    Then I should see the posts of my friends
    When I click "Load more"
    Then I should see more posts of my friends

  Scenario: Looking at your feed as a guest
    Given I am a guest
    When I try to look at my feed
    Then I should not see the feed page
