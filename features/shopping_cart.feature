Feature: Visit store and to select and buy items

  Users should be able to view the store inventory and browse items.
  Users can click on store items to add to cart and change quantities.
  Users should be able to check out their cart and make payment.

  Scenario: View an item's details
    Given there is an 'Oranges' item in the products list
    When the user goes to the products URL
    Then the user should see the 'Oranges' item in the product catalogue
    When the user clicks on the "Oranges" link
    Then the user should see the 'Oranges' item details
    And the user should see the 'Back' link
    When the user clicks on the "Back" link
    And the user should be able to go back to the home page

  Scenario: Add an item to cart when not logged in
    Given there is an 'Oranges' item in the products list
    When the user goes to the products URL
    And the user clicks on the 'Add to Cart' button for the 'Oranges' item
    Then the user should see the Cart
    And the user should see an 'Oranges' item in the cart
    And the 'Oranges' item should have quantity 1
    When the user clicks on the "Continue shopping" link
    Then the user should be able to go back to the home page

  Scenario: Add an item to cart when logged in
  Scenario: Check out cart
