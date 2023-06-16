@RegisterUser
  Feature: Check user register

    @User @Authentication @Register @Positive
    Scenario: User login with valid data
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone       | password | confirm_password |
        | halim    | faiz.hali@gmail.com | 01234567890 | 12345678 | 12345678         |
      Then User verify status code is 200
      Then User verify response is match with json schema "newUser.json"

    @User @Authentication @Register @Negative
    Scenario: User login with invalid data blank username
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone       | password | confirm_password |
        |          | faiz.hali@gmail.com | 01234567890 | 12345678 | 12345678         |
      Then User verify status code is 401
      Then User verify response body should contain "username is required"

    @User @Authentication @Register @Negative
    Scenario: User login with invalid data blank email
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email | phone       | password | confirm_password |
        | halim    |       | 01234567890 | 12345678 | 12345678         |
      Then User verify status code is 401
      Then User verify response body should contain "email is required"

    @User @Authentication @Register @Negative
    Scenario: User login with invalid data blank phone
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone | password | confirm_password |
        | halim    | faiz.hali@gmail.com |       | 12345678 | 12345678         |
      Then User verify status code is 401
      Then User verify response body should contain "phone is required"

    @User @Authentication @Register @Negative
    Scenario: User login with invalid data blank password
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone       | password | confirm_password |
        | halim    | faiz.hali@gmail.com | 01234567890 |          | 12345678         |
      Then User verify status code is 401
      Then User verify response body should contain "password is required"

    @User @Authentication @Register @Negative
    Scenario: User login with invalid data blank confirm password
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone       | password | confirm_password |
        | halim    | faiz.hali@gmail.com | 01234567890 | 12345678 |                  |
      Then User verify status code is 401
      Then User verify response body should contain "confirm password is required"

    @User @Authentication @Register @Negative
    Scenario: User login with invalid data wrong confirm password
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone       | password | confirm_password |
        | halim    | faiz.hali@gmail.com | 01234567890 | 12345678 | salah            |
      Then User verify status code is 401
      Then User verify response body should contain "please enter valid password"