@GetAdmin
  Feature: Check get admin

    @Admin @Authentication @Get @Positive
    Scenario: Get admin with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an API "/dashboard/admin" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success Get Admin"
      Then User verify response is match with json schema "admin.json"