@CreateFeedback
  Feature: Create Feedback

    @Admin @Feedback @Create @Positive
    Scenario: Create feedback with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "POST" with payload below and specific token
        | description       |
        | randomDescription |
      Then User verify status code is 200
      Then User verify response body should contain "Success"

    @Admin @Feedback @Create @Negative
    Scenario: Create feedback with invalid data blank description
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "POST" with payload below and specific token
        | description       |
        | isNull            |
      Then User verify status code is 400
      Then User verify response body should contain "Description is required"