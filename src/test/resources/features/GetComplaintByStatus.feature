@GetComplaintByStatus
  Feature: Get Complaint by Status

    @User @Complaint @Get @Positive
    Scenario: Get complaint by status with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an API "/complaintz/complaint?status=All" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"
      Then User verify response is match with json schema "complaintByStatus.json"