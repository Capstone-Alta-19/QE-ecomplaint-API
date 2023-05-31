@CategoriesAltaShopAPI
Feature: Check categories

  @AltaShopAPI @CategoriesAltaShopAPI @NewCategories @Positive
  Scenario: User can add new category
    Given User call an api "/api/categories" with method "POST" with payload below
      | name   | description         |
      | gaming | for gaming purposes |
    Then User verify status code is 200
    Then User verify response is match with json schema "newCategories.json"

  @AltaShopAPI @CategoriesAltaShopAPI @GetByIdCategories @Positive
  Scenario: User can get product by valid ID
    Given User call an api "/api/categories/12703" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "byIdCategories.json"

  @AltaShopAPI @CategoriesAltaShopAPI @GetByIdCategories @Negative
  Scenario: User can get product by invalid ID
    Given User call an api "/api/categories/a" with method "GET"
    Then User verify status code is 400

  @AltaShopAPI @CategoriesAltaShopAPI @GetAllCategories @Positive
  Scenario: User can get all products
    Given User call an api "/api/categories" with method "GET"
    Then User verify status code is 200
    Then User verify response is match with json schema "categories.json"

  @AltaShopAPI @CategoriesAltaShopAPI @DeleteByIdCategories @Positive
  Scenario: User can delete product by valid ID
    Given User call an api "/api/categories/1" with method "DELETE"
    Then User verify status code is 200
    Then User verify response is match with json schema "deleteCategories.json"

  @AltaShopAPI @CategoriesAltaShopAPI @DeleteByIdCategories @Negative
  Scenario: User can delete product by invalid ID
    Given User call an api "/api/categories/a" with method "DELETE"
    Then User verify status code is 400