Feature: Manage profiles

  Scenario: Profile page - Happy path
    Given I am a loggedin user
    And I am on the user profile page
    And I should see "this is a tweet"
    And I should see "Follow"
    And I follow "Follow"
    Then I should see "Unfollow"
    And I follow "Unfollow"
    Then I should see "Follow"
