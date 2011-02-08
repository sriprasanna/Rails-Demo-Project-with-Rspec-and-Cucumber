Given /^the following logins:$/ do |logins|
  Login.create!(logins.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) login$/ do |pos|
  visit logins_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following logins:$/ do |expected_logins_table|
  expected_logins_table.diff!(tableish('table tr', 'td,th'))
end

Given /^I have a user with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  User.create!(:username => username, :password => password, :password_confirmation => password, :email => "#{username}@dummy.com")
end

