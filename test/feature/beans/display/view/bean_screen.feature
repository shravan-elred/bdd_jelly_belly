Feature: Beans screen displays correct AppBar title

  Scenario: AppBar title is "Beans"
    Given Initialize Mock Beans List DI
    Given Mock Beans List
    Given the app is running
    Then I see {"Beans"} text

  Scenario: Beans List should display all bean details
    Given Initialize Mock Beans List DI
    Given Mock Beans List
    Given the app is running
    Then I see Bean image and name

  Scenario: Beans List when loading should display loader widget
    Given Initialize Mock Loading Beans DI
    Given Mock Loading Beans
    Given the app is running
    Then I see Bean loading widget   
  
  Scenario: Beans List when empty should display empty state widget
    Given Initialize Mock Empty Beans DI
    Given Mock Empty Beans
    Given the app is running
    Then I see Bean Empty widget   
