@AddNews
  Feature: Check add news

    @Admin @News @Add @Positive
    Scenario: Add new news with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an api "/dashboard/news" with method "POST" with payload below and specific token
        | news_name       | description           | category_id      |
        | randomNewsName  | randomDescription | 1                |
      Then User verify status code is 200
      Then User verify response is match with json schema "newNews.json"

    @Admin @News @Add @Negative
    Scenario: Add new news with invalid data blank news name
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an api "/dashboard/news" with method "POST" with payload below and specific token
        | description           | category_id      |
        | randomDescription | 2                |
      Then User verify status code is 401

    @Admin @News @Add @Negative
    Scenario: Add new news with invalid data blank description
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an api "/dashboard/news" with method "POST" with payload below and specific token
        | news_name       | category_id      |
        | randomNewsName  | 3                |
      Then User verify status code is 401

    @Admin @News @Add @Negative
    Scenario: Add new news with invalid data blank category id
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | admin    | admin123 |
      And user get token admin
      And User call an api "/dashboard/news" with method "POST" with payload below and specific token
        | news_name       | description           |
        | randomNewsName  | randomDescription |
      Then User verify status code is 401
