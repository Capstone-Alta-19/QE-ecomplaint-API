@AuthenticationAltaShopAPI
Feature: Check authentication

  @AltaShopAPI @AuthenticationAltaShopAPI @RegisterAuthentication @Positive
  Scenario: User register with valid data
    Given User call an api "/api/auth/register" with method "POST" with payload below
      | email            | password | fullname           |
      | someone@mail.com | 123123   | Firstname Lastname |
    Then User verify status code is 200
    Then User verify response is match with json schema "infoRegister.json"

  @AltaShopAPI @AuthenticationAltaShopAPI @RegisterAuthentication @Negative
  Scenario: User register with invalid data
    Given User call an api "/api/auth/register" with method "POST" with payload below
      | email            | password | fullname           |
      | someone@mail.com |          | Firstname Lastname |
    Then User verify status code is 400
    Then User verify response body should contain "password is required"

  @AltaShopAPI @AuthenticationAltaShopAPI @LoginAuthentication @Positive
  Scenario: User login with valid data
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Then User verify status code is 200
    Then User verify "data" is exist

  @AltaShopAPI @AuthenticationAltaShopAPI @LoginAuthentication @Negative
  Scenario: User login with invalid data
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | fewfwef  |
    And user get token
    Then User verify status code is 400
    Then User verify response body should contain "email or password is invalid"

  @AltaShopAPI @AuthenticationAltaShopAPI @InfoAuthentication @Positive
  Scenario: User can get all info authentication
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/auth/info" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "info.json"

