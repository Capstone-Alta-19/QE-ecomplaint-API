@GetComplaintByCategoryID
  Feature: Get Complaint by Category ID

    @Admin @Complaint @Get @Positive
    Scenario: Get complaint by category id with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an API "/complaintz/complaint/category/1?sort=desc" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"
      Then User verify response is match with json schema "complaintByCategoryID.json"