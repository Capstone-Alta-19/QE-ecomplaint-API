@UpdatePassword
  Feature: Update Password

    @User @Update @Password @Positive
    Scenario: User update password with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/user/password" with method "PUT" with payload below and specific token
        | old_password | new_password |
        | 087654321    | 12345678     |
      Then User verify status code is 200
      Then User verify response body should contain "success update password"
      And User call an api "/complaintz/user/password" with method "PUT" with payload below and specific token
        | old_password | new_password |
        | 12345678     | 087654321    |

    @User @Update @Password @Negative
    Scenario: User update password with invalid data blank old password
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/user/password" with method "PUT" with payload below and specific token
        | new_password |
        | 087654321    |
      Then User verify status code is 400
      Then User verify response body should contain "OldPassword is required"

    @User @Update @Password @Negative
    Scenario: User update password with invalid data blank new password
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/user/password" with method "PUT" with payload below and specific token
        | old_password |
        | 12345678     |
      Then User verify status code is 400
      Then User verify response body should contain "NewPassword is required"


