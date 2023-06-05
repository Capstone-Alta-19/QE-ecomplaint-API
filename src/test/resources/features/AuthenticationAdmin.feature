@authenticationAdmin
  Feature: Check admin authentication

    @Admin @Authentication @Login @Positive
    Scenario: User login with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      Then User verify status code is 200
      Then User verify "data" is exist

    @Admin @Authentication @Login @Negative
    Scenario: User login with invalid data wrong password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | salah    |
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"

    @Admin @Authentication @Login @Negative
    Scenario: User login with invalid data wrong username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | salah    | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"

    @Admin @Authentication @Login @Negative
    Scenario: User login with invalid data blank password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    |          |
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"

    @Admin @Authentication @Login @Negative
    Scenario: User login with invalid data blank username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        |          | admin123 |
      And user get token
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"