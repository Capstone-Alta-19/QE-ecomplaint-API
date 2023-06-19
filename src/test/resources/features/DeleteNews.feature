@DeleteNews
  Feature: Delete News

    @Admin @News @Delete @Positive
    Scenario: Delete news with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an API "/admin/news/3" with method "DELETE" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success Delete News"
      Then User verify response is match with json schema "Admin.json"