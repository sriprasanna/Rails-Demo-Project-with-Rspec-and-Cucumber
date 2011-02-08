Given /^the following tweets:$/ do |tweets|
  Tweet.create!(tweets.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) tweet$/ do |pos|
  visit tweets_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tweets:$/ do |expected_tweets_table|
  expected_tweets_table.diff!(tableish('table tr', 'td,th'))
end

Given /^I am a loggedin user$/ do
  Given "I am on the login page"
  Given "I have a user with username \"dummy\" and password \"password\""
  And "I fill in \"dummy\" for \"Username or Email Address\""
  And "I fill in \"password\" for \"Password\""
  And "I press \"Log in\""
  And "I should be on the home page"
end

