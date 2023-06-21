@GetDashboardNotification
  Feature: Get Dashboard Notification

    @Admin @DashboardNotification @Get @Positive
    Scenario: Get dashboard notification with valid data
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password |
        | halim             | 12345678 |
      And user get token user
      And User call an API "/dashboard/notification" with method "GET" and specific token
      Then User verify status code is 200
      Then User verify response body should contain "Success Get Notification"
      Then User verify response is match with json schema "dashboardNotification.json"