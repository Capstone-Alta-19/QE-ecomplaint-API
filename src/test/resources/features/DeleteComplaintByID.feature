@DeleteComplaintByID
  Feature: Delete Complaint By ID

    @User @Complaint @Delete @Positive
    Scenario: Delete user complaint with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an API "/complaintz/complaint/3" with method "DELETE" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"

    @Admin @Complaint @Delete @Positive
    Scenario: Delete admin complaint with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an API "/dashboard/complaint/11" with method "DELETE" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"