@GetProfile
  Feature: Get Profile

    @User @Profile @Get @Positive
    Scenario: Get user profile with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an API "/complaintz/user" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "success get user profile"
      Then User verify response is match with json schema "profile.json"