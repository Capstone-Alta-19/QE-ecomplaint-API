@UpdateStatusAndType
  Feature: Update Status and Type

    @Admin @StatusType @Update @Positive
    Scenario: Update status and type with valid data
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "PUT" with payload below and specific token
        | status   | type      |
        | Proccess | Complaint |
      Then User verify status code is 200
      Then User verify response body should contain "Success"

    @Admin @StatusType @Update @Negative
    Scenario: Update status and type with invalid data wrong status
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "PUT" with payload below and specific token
        | status | type      |
        | salah  | Complaint |
      Then User verify status code is 400
      Then User verify response body should contain "Status must be one of Pending Proccess Resolved"

    @Admin @StatusType @Update @Negative
    Scenario: Update status and type with invalid data wrong type
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "PUT" with payload below and specific token
        | status   | type      |
        | Proccess | salah     |
      Then User verify status code is 400
      Then User verify response body should contain "Type must be one of Complaint Aspiration"

    @Admin @StatusType @Update @Negative
    Scenario: Update status and type with invalid data blank type
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "PUT" with payload below and specific token
        | status   |
        | Proccess |
      Then User verify status code is 400
      Then User verify response body should contain "Type is required"

    @Admin @StatusType @Update @Negative
    Scenario: Update status and type with invalid data blank status
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/complaint/99" with method "PUT" with payload below and specific token
        | type      |
        | Complaint |
      Then User verify status code is 400
      Then User verify response body should contain "Status is required"