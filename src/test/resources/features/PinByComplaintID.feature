@PinByComplaintID
  Feature: Pin By Complaint ID

    @User @Complaint @Pin @Positive
    Scenario: Pin complaint with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an API "/complaintz/complaint/6/pin" with method "POST" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"
