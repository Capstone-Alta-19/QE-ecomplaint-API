@DashboardTotal
  Feature: Get Dashboard

    @Admin @Complaint @Get @Positive
    Scenario: Get admin complaint by id with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an API "/dashboard/complaint?sort=desc&type=Aspiration&search=&page=1&limit=10" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"
      Then User verify response is match with json schema "dashboard.json"