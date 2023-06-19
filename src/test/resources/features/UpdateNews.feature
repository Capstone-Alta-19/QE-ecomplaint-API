@UpdateNews
  Feature: Update News

    @Admin @News @Update @Positive
    Scenario: Update news with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/news/21" with method "PUT" with payload below and specific token
        | news_name       | description       |
        | randomNewsName  | randomDescription |
      Then User verify status code is 200
      Then User verify response body should contain "success update news"

    @Admin @News @Update @Negative
    Scenario: Update news with invalid data blank news name
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/news/21" with method "PUT" with payload below and specific token
        | description       |
        | randomDescription |
      Then User verify status code is 400
      Then User verify response body should contain "news name is required"

    @Admin @News @Update @Negative
    Scenario: Update news with invalid data blank description
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/news/21" with method "PUT" with payload below and specific token
        | news_name       |
        | randomNewsName  |
      Then User verify status code is 400
      Then User verify response body should contain "description is required"