@AddAdmin
  Feature: Check add admin

    @Admin @Authentication @Add @Positive
    Scenario: User can add admin with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name | role         | username | password |
        | eka  | admin berita | admin    | admin123 |
      Then User verify status code is 200
      Then User verify response is match with json schema "newAdmin.json"

    @Admin @Authentication @Add @Negative
    Scenario: user add admin with blank name
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name | role         | username | password |
        |      | admin berita | admin    | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

    @Admin @Authentication @Add @Negative
    Scenario: user add admin with blank role
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name | role  | username | password |
        | eka  |       | admin    | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

    @Admin @Authentication @Add @Negative
    Scenario: user add admin with blank username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name | role         | username | password |
        | eka  | admin berita |          | admin123 |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

    @Admin @Authentication @Add @Negative
    Scenario: user add admin with blank password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name | role         | username | password |
        | eka  | admin berita | admin    |          |
      Then User verify status code is 400
      Then User verify response body should contain "data cannot entry"

