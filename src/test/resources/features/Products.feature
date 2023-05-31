@ProductsAltaShopAPI
Feature: Check product

  @AltaShopAPI @ProductsAltaShopAPI @GetAllProducts @Positive
  Scenario: User can get all products
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "products.json"

  @AltaShopAPI @ProductsAltaShopAPI @NewProducts @Positive
  Scenario: User can add new product
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products" with method post to add new product
    Then User verify status code is 200
    Then User verify response is match with json schema "newProducts.json"

  @AltaShopAPI @ProductsAltaShopAPI @GetByIdProducts @Positive
  Scenario: User can get product by valid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/1" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "byIdProducts.json"

  @AltaShopAPI @ProductsAltaShopAPI @GetByIdProducts @Negative
  Scenario: User can get product by invalid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/a" with method "GET"
    Then User verify status code is 400

  @AltaShopAPI @ProductsAltaShopAPI @DeleteByIdProducts @Positive
  Scenario: User can delete product by valid ID
    Given User call an api "/api/products/1" with method "DELETE"
    Then User verify status code is 200
    Then User verify response is match with json schema "deleteProducts.json"

  @AltaShopAPI @ProductsAltaShopAPI @DeleteByIdProducts @Negative
  Scenario: User can delete product by invalid ID
    Given User call an api "/api/products/a" with method "DELETE"
    Then User verify status code is 400

  @AltaShopAPI @ProductsAltaShopAPI @NewRatingsProducts @Positive
  Scenario: User can add new rating
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/2/ratings" with method "POST" with payload below for auth
      | ratings |
      | 4       |
    Then User verify status code is 200
    Then User verify response is match with json schema "newRatings.json"

  @AltaShopAPI @ProductsAltaShopAPI @RatingsByIdProducts @Positive
  Scenario: User can get rating by valid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/2/ratings" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "ratings.json"

  @AltaShopAPI @ProductsAltaShopAPI @RatingsByIdProducts @Negative
  Scenario: User can get rating by invalid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/a/ratings" with method "GET"
    Then User verify status code is 400

  @AltaShopAPI @ProductsAltaShopAPI @NewCommentsProducts @Positive
  Scenario: User can add new comment
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/2/ratings" with method "POST" with payload below for auth
      | comment                                                                   |
      | the games are great including Gran Turismo 7 but sadly GT4 is much better |
    Then User verify status code is 200
    Then User verify response is match with json schema "newComments.json"

  @AltaShopAPI @ProductsAltaShopAPI @CommentsByIdProducts @Positive
  Scenario: User can get comment by valid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/2/comments" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "comments.json"

  @AltaShopAPI @ProductsAltaShopAPI @CommentsByIdProducts @Negative
  Scenario: User can get comment by invalid ID
    Given User call an api "/api/auth/login" with method "POST" with payload below
      | email            | password |
      | someone@mail.com | 123123   |
    And user get token
    Given User call an api "/api/products/a/comments" with method "GET"
    Then User verify status code is 400




