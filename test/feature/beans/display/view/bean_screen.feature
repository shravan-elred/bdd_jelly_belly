Feature: Beans screen displays correct AppBar title

  Scenario: AppBar title is "Beans"
    Given the app is running
    Then I see {"Beans"} text