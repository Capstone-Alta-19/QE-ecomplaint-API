@UpdateAdmin
  Feature: Update Admin

  @Admin @Authentication @Update @Positive
  Scenario: Update admin with valid data
    Given User call an api "/login/admin" with method "POST" with payload below
      | username | password |
      | asmar    | asmar123 |
    And user get token admin
    And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
      | old_password | new_password | confirm_password |
      | asmar123     | 12345678     | 12345678         |
    Then User verify status code is 200
    Then User verify response body should contain "Success Updated Admin"
    And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
      | old_password | new_password | confirm_password |
      | 12345678     | asmar123     | asmar123         |

    @Admin @Authentication @Update @Negative
    Scenario: Update admin with invalid data blank old password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
        | new_password | confirm_password |
        | 12345678     | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "OldPassword is required"

    @Admin @Authentication @Update @Negative
    Scenario: Update admin with invalid data blank new password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
        | old_password | confirm_password |
        | asmar123     | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "NewPassword is required"

    @Admin @Authentication @Update @Negative
    Scenario: Update admin with invalid data blank confirm password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
        | old_password | new_password |
        | asmar123     | 12345678     |
      Then User verify status code is 400
      Then User verify response body should contain "ConfirmPassword is required"

    @Admin @Authentication @Update @Negative
    Scenario: Update admin with invalid data wrong old password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
        | old_password | new_password | confirm_password |
        | salahpass    | 12345678     | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "old password is not correct"

    @Admin @Authentication @Update @Negative
    Scenario: Update admin with invalid data wrong confirm password
      Given User call an api "/login/admin" with method "POST" with payload below
        | username | password |
        | asmar    | asmar123 |
      And user get token admin
      And User call an api "/dashboard/admin" with method "PUT" with payload below and specific token
        | old_password | new_password | confirm_password |
        | asmar123     | 12345678     | salahpass        |
      Then User verify status code is 400
      Then User verify response body should contain "new password and confirm password not match"

