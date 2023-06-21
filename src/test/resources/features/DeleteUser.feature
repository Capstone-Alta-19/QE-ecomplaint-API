@DeleteUser
  Feature: Delete User

    @User @Authentication @Delete @Positive
    Scenario: Delete user with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | asmar123          | 11223344 |
      And user get token user
      And User call an API "/complaintz/user" with method "DELETE" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "success delete user"