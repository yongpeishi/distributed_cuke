Feature: Accessing different websites
  As an internet user
  I want to access all websites
  so that I can get all information available

  Scenario: Access google
  When I go to "https://www.google.com.au/"
  Then I should see the google search box

  Scenario: Access facebook
  When I go to "https://www.facebook.com/"
  Then I should see facebook

  Scenario: Access google2
  When I go to "https://www.google.com.au/"
  Then I should see random stuff

  Scenario: Access facebook2
  When I go to "https://www.facebook.com/"
  Then I should see facebook

  Scenario: Access google3
  When I go to "https://www.google.com.au/"
  Then I should see the google search box

  Scenario: Access facebook3
  When I go to "https://www.facebook.com/"
  Then I should see facebook
