@AuthenticationAdmin
  Feature: Check admin authentication

    @Admin @Authenticaton @Login @Positive
    Scenario: User login with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      Then User verify status code is 200
      Then User verify "data" is exist

    @Admin @Authenticaton @Login @Negative
    Scenario: User login with invalid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      Then User verify status code is 400
      Then User verify "data" is exist