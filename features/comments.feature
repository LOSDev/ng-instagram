@javascript
Feature: Comments

  Scenario: Create a comment
    Given I am a logged in user
    When I create a comment
    Then I should see the comment

  Scenario: Create invalid comment
    Given I am a logged in user
    When I create an invalid comment
    Then the comment should not be created

  Scenario: Delete a comment
    Given I am a logged in user
    When I create a comment
    Then I should see the comment
    When I delete the comment
    Then I should not see the comment

  Scenario: Delete comment of another user
    Given I am a logged in user
    When I see a comment from another user
    Then I should not see the delete link

  Scenario: Paginate Comments
    Given I am a logged in user
    When I visit a post with 21 comments
    Then I should see 20 comments
    When I click "load more comments"
    Then I should see 21 comments
