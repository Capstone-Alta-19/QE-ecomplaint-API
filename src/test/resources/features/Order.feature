@OrderAltaShopAPI
Feature: Check order

  @AltaShopAPI @OrderAltaShopAPI @NewOrder @Positive
  Scenario: User can add new order
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/orders" with method post to add new order
    Then User verify status code is 200
    Then User verify response is match with json schema "newOrder.json"

  @AltaShopAPI @OrderAltaShopAPI @GetAllOrder @Positive
  Scenario: User can get all order
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/orders" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "order.json"

  @AltaShopAPI @OrderAltaShopAPI @GetByIdOrder @Positive
  Scenario: User can get order by valid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/orders/1" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "byIdOrder.json"

  @AltaShopAPI @OrderAltaShopAPI @GetByIdOrder @Negative
  Scenario: User can get order by invalid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/orders/a" with method "GET"
    Then User verify status code is 400