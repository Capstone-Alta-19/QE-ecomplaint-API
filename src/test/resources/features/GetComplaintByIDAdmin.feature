@GetComplaintByIDAdmin
  Feature: Get Complaint by ID Admin

    @Admin @Complaint @Get @Positive
    Scenario: Get admin complaint by id with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an API "/dashboard/complaint/1" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"
      Then User verify response is match with json schema "complaintByIDAdmin.json"