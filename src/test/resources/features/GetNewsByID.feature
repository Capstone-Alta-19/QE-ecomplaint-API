@GetNewsByID
  Feature: Get News by ID

    @User @News @Get @Positive
    Scenario: Get news id with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an API "/complaintz/news/2" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "success"
      Then User verify response is match with json schema "newsByID.json"