@DeleteNews
  Feature: Delete News

    @Admin @News @Delete @Positive
    Scenario: Delete news with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an API "/complaintz/complaint/11" with method "DELETE" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success"