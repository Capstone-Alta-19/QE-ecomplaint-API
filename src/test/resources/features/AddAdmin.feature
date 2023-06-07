@AddAdmin
  Feature: Add of admin

    @Admin @AddAdmin @Positive
      Scenario: User can add admin with valid data
      Given user call an api "/admin" with method "POST" with payload below
        | name | role         | username | password |
        | eka  | admin berita | admin    | admin123 |
      Then User verify status code is 200
      Then User verify "data" is exist

    @Admin @AddAdmin @Negative
      Scenario: user add admin with blank name
      Given user call an api "/admin" with method "POST" with payload below
        | name | role         | username | password |
        |      | admin berita | admin    | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

    @Admin @AddAdmin @Negative
    Scenario: user add admin with blank role
      Given user call an api "/admin" with method "POST" with payload below
        | name | role  | username | password |
        | eka  |       | admin    | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

    @Admin @AddAdmin @Negative
    Scenario: user add admin with blank username
      Given user call an api "/admin" with method "POST" with payload below
        | name | role         | username | password |
        | eka  | admin berita |          | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

    @Admin @AddAdmin @Negative
    Scenario: user add admin with blank password
      Given user call an api "/admin" with method "POST" with payload below
        | name | role         | username | password |
        | eka  | admin berita | admin    |          |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

