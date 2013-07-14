When /^I go to "(.*)"$/ do |link|
  page.visit link
end

Then /^I should see the google search box$/ do
  page.has_css?('#gbqfq').should be_true
end

Then /^I should see facebook$/ do
  page.has_content?('Facebook').should be_true
end

Then /^I should see random stuff$/ do
  page.has_content?('fhjsafhsjafask').should be_true
end
