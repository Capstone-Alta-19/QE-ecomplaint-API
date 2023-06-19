@RegisterUser
  Feature: Check user register

    @User @Authentication @Register @Positive
    Scenario: User register with valid data
      Given User call an api "/register/user" with method "POST" with payload below
        | username   | email       | phone        | date_birth | password | confirm_password |
        | randomName | randomEmail | 082122567830 | 2001-02-08 | 12345678 | 12345678         |
      Then User verify status code is 200
      Then User verify "token" is exist
      Then User verify response body should contain "success create new user"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data blank username
      Given User call an api "/register/user" with method "POST" with payload below
        | email       | phone       | date_birth | password | confirm_password |
        | randomEmail | randomPhone | 2001-02-08 | 12345678 | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "Username is required"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data blank email
      Given User call an api "/register/user" with method "POST" with payload below
        | username   | phone       | date_birth | password | confirm_password |
        | randomName | randomPhone | 2001-02-08 | 12345678 | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "Email is required"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data blank phone
      Given User call an api "/register/user" with method "POST" with payload below
        | username   | email       | date_birth | password | confirm_password |
        | randomName | randomEmail | 2001-02-08 | 12345678 | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "Phone is required"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data blank password
      Given User call an api "/register/user" with method "POST" with payload below
        | username   | email       | phone       | confirm_password |
        | randomName | randomEmail | randomPhone | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "Password is required"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data blank confirm password
      Given User call an api "/register/user" with method "POST" with payload below
        | username   | email       | phone       | date_birth | password |
        | randomName | randomEmail | randomPhone | 2001-02-08 | 12345678 |
      Then User verify status code is 400
      Then User verify response body should contain "ConfirmPassword is required"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data wrong confirm password
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email               | phone       | password | confirm_password |
        | halim    | faiz.hali@gmail.com | 01234567890 | 12345678 | salah            |
      Then User verify status code is 400
      Then User verify response body should contain "Password Not Match"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data taken username
      Given User call an api "/register/user" with method "POST" with payload below
        | username | email       | phone       | password | confirm_password |
        | halim    | randomEmail | 01234567890 | 12345678 | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "username already registered"

    @User @Authentication @Register @Negative
    Scenario: User register with invalid data taken email
      Given User call an api "/register/user" with method "POST" with payload below
        | username   | email               | phone       | password | confirm_password |
        | randomName | faiz.hali@gmail.com | 01234567890 | 12345678 | 12345678         |
      Then User verify status code is 400
      Then User verify response body should contain "email already registered"