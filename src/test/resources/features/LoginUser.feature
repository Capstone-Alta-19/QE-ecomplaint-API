@LoginUser
  Feature: Login User

    @User @Authentication @Login @Positive
    Scenario: User login with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      Then User verify status code is 200
      Then User verify "token" is exist
      Then User verify response body should contain "success login"

    @User @Authentication @Login @Negative
    Scenario: User login with invalid data wrong password
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | salahpass |
      Then User verify status code is 400
      Then User verify response body should contain "wrong password"

    @User @Authentication @Login @Negative
    Scenario: User login with invalid data wrong username
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | salah             | 12345678 |
      Then User verify status code is 400
      Then User verify response body should contain "username or email not found"

    @User @Authentication @Login @Negative
    Scenario: User login with invalid data blank password
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email |
        | halim             |
      Then User verify status code is 400

    @User @Authentication @Login @Negative
   Scenario: User login with invalid data blank username
      Given User call an api "/login/user" with method "POST" with payload below
        | password |
        | 12345678 |
      Then User verify status code is 400