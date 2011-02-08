Feature: Manage logins
  In order to access the site
  user has to create account
  wants to access the account information and tweets

  Scenario: Signup - Happy path
    Given I am on the signup page
    And I fill in "dummy" for "Username"
    And I fill in "dummy@dummy.com" for "Email Address"
    And I fill in "password" for "Password"
    And I fill in "password" for "Confirm Password"
    And I press "Sign up"
    And I should be on the home page

  Scenario: Signup - Failures
    Given I am on the signup page
    And I press "Sign up"
    And I should see "Username can't be blank"
    And I should see "Email is invalid"
    And I should see "Password can't be blank"
    And I fill in "password" for "Password"
    And I press "Sign up"
    And I should see "Password doesn't match confirmation"
    And I fill in "!!!" for "Username"
    And I press "Sign up"
    And I should see "Username should only contain letters, numbers, or .-_@"

  Scenario: Login - Happy path
    Given I am on the login page
    Given I have a user with username "dummy" and password "password"
    And I fill in "dummy" for "Username or Email Address"
    And I fill in "password" for "Password"
    And I press "Log in"
    And I should be on the home page

  Scenario: Login - Failures
    Given I am on the login page
    And I press "Log in"
    And I should see "Invalid login or password."
