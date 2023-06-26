@UpdateUser
  Feature: Update User

    @User @Authentication @Update @Positive
    Scenario: User update user with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an api "/complaintz/user/1" with method "PUT" with payload below and specific token
        | full_name      | phone        | date_birth |
        | randomFullName | 082122121234 | 2001-02-08 |
      Then User verify status code is 200
      Then User verify response body should contain "success update user"

    @User @Authentication @Update @Negative
    Scenario: User update user with invalid data blank full name
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an api "/complaintz/user/1" with method "PUT" with payload below and specific token
        | phone        | date_birth |
        | 082122121234 | 2001-02-08 |
      Then User verify status code is 200
      Then User verify response body should contain "success update user"

    @User @Authentication @Update @Negative
    Scenario: User update user with invalid data blank phone
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an api "/complaintz/user/1" with method "PUT" with payload below and specific token
        | full_name      | date_birth |
        | randomFullName | 2001-02-08 |
      Then User verify status code is 200
      Then User verify response body should contain "success update user"

    @User @Authentication @Update @Negative
    Scenario: User update user with invalid data blank date birth
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an api "/complaintz/user/1" with method "PUT" with payload below and specific token
        | full_name      | phone        |
        | randomFullName | 082122121234 |
      Then User verify status code is 200
      Then User verify response body should contain "success update user"
