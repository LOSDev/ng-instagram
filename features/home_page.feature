@javascript
Feature: Welcome Page

  Scenario: Visit home page
    Given I am a guest
    When I visit the homepage
    Then I should see the logo
    And I should see a Register link
