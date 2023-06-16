@LoginAdmin
  Feature: Check admin login

    @Admin @Authentication @Login @Positive
    Scenario: Admin login with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      Then User verify status code is 200
      Then User verify "token" is exist

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data wrong password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | salah    |
      Then User verify status code is 400

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data wrong username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | salah    | admin123 |
      Then User verify status code is 400

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data blank password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username |
        | admin    |
      Then User verify status code is 400

    @Admin @Authentication @Login @Negative
    Scenario: Admin login with invalid data blank username
      Given User call an api "/login/admin" with method "POST" with payload below
        | password |
        | admin123 |
      Then User verify status code is 400
