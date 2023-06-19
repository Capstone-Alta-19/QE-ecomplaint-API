@LoginAdmin
  Feature: Login Admin

    @Admin @Authentication @Login @Positive
    Scenario: Admin login with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      Then User verify status code is 200
      Then User verify "token" is exist
      Then User verify response body should contain "Success Login"

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data wrong password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password  |
        | admin    | salahpass |
      Then User verify status code is 400
      Then User verify response body should contain "wrong password"

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data wrong username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | salah    | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "username not found"

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data blank password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username |
        | admin    |
      Then User verify status code is 400
      Then User verify response body should contain "Password is required"

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data blank username
      Given User call an api "/login/admin" with method "POST" with payload below
        | password |
        | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "Username is required"
