@GetNews
  Feature: Get News

    @Admin @News @Get @Positive
    Scenario: Get news with valid data
      And User call an API "/news" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "success"
      Then User verify response is match with json schema "news.json"