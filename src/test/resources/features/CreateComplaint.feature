@CreateComplaint
  Feature: Create Complaint

    @User @Create @Complaint @Positive
    Scenario: Create complaint with valid data true
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | category_id      | photo_url                 | video_url                 | description       | is_public |
        | Aspiration | randomCategoryID | https://picsum.photos/200 | http://y2u.be/UT5F9AXjwhg | randomDescription | isTrue    |
      Then User verify status code is 200
      Then User verify response body should contain "Success Created Complaint"

    @User @Create @Complaint @Positive
    Scenario: Create complaint with valid data false
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | category_id      | photo_url                 | video_url                 | description       | is_public |
        | Aspiration | randomCategoryID | https://picsum.photos/200 | http://y2u.be/UT5F9AXjwhg | randomDescription | isFalse   |
      Then User verify status code is 200
      Then User verify response body should contain "Success Created Complaint"

    @User @Create @Complaint @Negative
    Scenario: Create complaint with invalid data blank type
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | category_id      | photo_url                 | video_url                 | description       | is_public |
        | randomCategoryID | https://picsum.photos/200 | http://y2u.be/UT5F9AXjwhg | randomDescription | isFalse   |
      Then User verify status code is 400
      Then User verify response body should contain "Type is required"

    @User @Create @Complaint @Negative
    Scenario: Create complaint with invalid data blank category id
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | photo_url                 | video_url                 | description       | is_public |
        | Aspiration | https://picsum.photos/200 | http://y2u.be/UT5F9AXjwhg | randomDescription | isFalse   |
      Then User verify status code is 400
      Then User verify response body should contain "CategoryID is required"

    @User @Create @Complaint @Negative
    Scenario: Create complaint with invalid data blank photo url
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | category_id      | video_url                 | description       | is_public |
        | Aspiration | randomCategoryID | http://y2u.be/UT5F9AXjwhg | randomDescription | isFalse   |
      Then User verify status code is 200
      Then User verify response body should contain "Success Created Complaint"

    @User @Create @Complaint @Negative
    Scenario: Create complaint with invalid data blank video url
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | category_id      | photo_url                 | description       | is_public |
        | Aspiration | randomCategoryID | https://picsum.photos/200 | randomDescription | isFalse   |
      Then User verify status code is 200
      Then User verify response body should contain "Success Created Complaint"

    @User @Create @Complaint @Negative
    Scenario: Create complaint with invalid data blank description
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | category_id      | photo_url                 | video_url                 | is_public |
        | Aspiration | randomCategoryID | https://picsum.photos/200 | http://y2u.be/UT5F9AXjwhg | isFalse   |
      Then User verify status code is 400
      Then User verify response body should contain "Description is required"

    @User @Create @Complaint @Negative
    Scenario: Create complaint with invalid data blank is public
      Given User call an api "/login/user" with method "POST" with payload below
        | username_or_email | password  |
        | halim             | 087654321 |
      And user get token user
      And User call an api "/complaintz/complaint" with method "POST" with payload below and specific token
        | type       | category_id      | photo_url                 | video_url                 | description       |
        | Aspiration | randomCategoryID | https://picsum.photos/200 | http://y2u.be/UT5F9AXjwhg | randomDescription |
      Then User verify status code is 400
      Then User verify response body should contain "isPublic is required"