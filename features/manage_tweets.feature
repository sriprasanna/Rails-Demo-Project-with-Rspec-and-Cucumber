Feature: Manage tweets
  
  Scenario: New Tweet - Happy Path
    Given I am a loggedin user
    And I am on the home page
    And I fill in "tweet_text" with "this is a tweet" 
    And I press "Create Tweet"
    And I should see "this is a tweet"

  Scenario: New Tweet - Errors
    Given I am a loggedin user
    And I am on the home page
    And I press "Create Tweet"
    And I should see "OOPS! Something went wrong!"
