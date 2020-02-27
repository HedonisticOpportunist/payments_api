Feature: Payments API

  The login and logout are carried out in the hooks file.

  Background: I have authenticated to Payment API service and retrieve a valid token
    Given I retrieve a valid token

  Scenario: Create a quote with no query parameters
    When I create a quote with no query parameters
    Then the response should include specific error messages

  Scenario Outline: Create a quote for selling GPB and buying USD (sell side)
    When I create a quote for selling GBP and buying USD for "<sell_amount>"
    Then the response should include the "<sell_amount>

    Examples:
      | sell_amount |
      | 1000        |
      | 24000       |
      | 11          |
