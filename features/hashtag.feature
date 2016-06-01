@javascript
Feature: Hashtag

  Scenario: Follow a hashtag
    Given I am a guest
    When I visit a post
    And I click on a hashtag
    Then I should see all posts with the hashtag

  Scenario: Paginate Hashtag Posts
    Given I am a guest
    When there are 13 posts with a hashtag
    And I visit the hashtag path
    Then I should see 12 posts
    When I click "Load more"
    Then I should see 13 posts
