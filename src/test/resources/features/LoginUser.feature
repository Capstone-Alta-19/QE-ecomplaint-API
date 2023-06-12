@LoginUser
  Feature: Check user login

    @User @Authentication @Login @Positive
    Scenario: User login with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username | password |
        | halim    | 12345678 |
      Then User verify status code is 200
      Then User verify "data" is exist

    @User @Authentication @Login @Negative
    Scenario: User login with invalid data wrong password
      Given User call an api "/login/user" with method "POST" with payload below
        | username | password |
        | halim    | salah    |
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"

    @User @Authentication @Login @Negative
    Scenario: User login with invalid data wrong username
      Given User call an api "/login/user" with method "POST" with payload below
        | username | password |
        | salah    | 12345678 |
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"

    @User @Authentication @Login @Negative
    Scenario: User login with invalid data blank password
      Given User call an api "/login/user" with method "POST" with payload below
        | username | password |
        | halim    |          |
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"

    @User @Authentication @Login @Negative
   Scenario: User login with invalid data blank username
      Given User call an api "/login/user" with method "POST" with payload below
        | username | password |
        |          | 12345678 |
      And user get token
      Then User verify status code is 400
      Then User verify response body should contain "email or password is invalid"