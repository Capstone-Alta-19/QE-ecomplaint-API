@AddAdmin
  Feature: Check add admin

    @Admin @Authentication @Add @Positive
    Scenario: User can add admin with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name       | role  | username   | password       |
        | randomName | Admin | randomName | randomPassword |
      Then User verify status code is 200
      Then User verify response body should contain "Success Added Admin"

    @Admin @Authentication @Add @Negative
    Scenario: User add admin with blank name
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | role  | username   | password       |
        | Admin | randomName | randomPassword |
      Then User verify status code is 400
      Then User verify response body should contain "Name is required"

    @Admin @Authentication @Add @Negative
    Scenario: User add admin with blank role
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name       | username   | password       |
        | randomName | randomName | randomPassword |
      Then User verify status code is 400
      Then User verify response body should contain "Role is required"

    @Admin @Authentication @Add @Negative
    Scenario: User add admin with blank username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name       | role  | password       |
        | randomName | Admin | randomPassword |
      Then User verify status code is 400
      Then User verify response body should contain "Username is required"

    @Admin @Authentication @Add @Negative
    Scenario: User add admin with blank password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name       | role  | username   |
        | randomName | Admin | randomName |
      Then User verify status code is 400
      Then User verify response body should contain "Password is required"

    @Admin @Authentication @Add @Negative
    Scenario: User add admin with taken username
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token
      And User call an api "/dashboard/admin" with method "POST" with payload below and specific token
        | name       | role  | username | password       |
        | randomName | Admin | admin    | randomPassword |
      Then User verify status code is 400
      Then User verify response body should contain "username already used"

