@CreateComment
  Feature: Create Comment

    @User @Comment @Create @Positive
    Scenario: Create comment with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint/6/comment" with method "POST" with payload below and specific token
        | description       |
        | randomDescription |
      Then User verify status code is 200
      Then User verify response body should contain "Success Created Comment"

    @User @Comment @Create @Negative
    Scenario: Create comment with invalid data blank description
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint/6/comment" with method "POST" with payload below and specific token
        | description       |
        | isNull            |
      Then User verify status code is 400
      Then User verify response body should contain "Description is required"