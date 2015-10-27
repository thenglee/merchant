Given(/^there is an 'Oranges' item in the products list$/) do
  Product.create(title: "Oranges", price: 2.99, description: "Bag of 6 Valencia oranges", image_url: "oranges.jpg", stock: 50)
end

When(/^the user goes to the products URL$/) do
  visit products_path
end

Then(/^the user should see the 'Oranges' item in the product catalogue$/) do
  expect(page).to have_content('Oranges')
end

When(/^the user clicks on the 'Oranges' link$/) do
  click_link 'Oranges'
end

Then(/^the user should see the 'Oranges' item details$/) do
  expect(page).to have_content('Title: Oranges')
  expect(page).to have_content('Price: $2.99')
  expect(page).to have_content('Description: Bag of 6 Valencia oranges')
  expect(page).to have_content('Stock: 50 In Stock')
end

Then(/^the user should see the 'Back' link$/) do
  find_link('Back').visible?
end

When(/^the user clicks on the 'Back' link$/) do
  click_link 'Back'
end

When(/^the user should be able to go back to the home page$/) do
  expect(current_path).to eq root_path
end

When(/^the user clicks on the 'Add to Cart' button for the 'Oranges' item$/) do
  click_button 'Add to Cart'
end

Then(/^the user should see the Cart$/) do
  expect(page).to have_content('Your Cart')
end

Then(/^the user should see an 'Oranges' item in the cart$/) do
  expect(page).to have_content('Oranges')
end

Then(/^the 'Oranges' item should have quantity (\d+)$/) do |item_quantity|
  expect(page).to have_content(item_quantity)
end

When(/^the user clicks on 'Continue shopping'$/) do
  click_link 'Continue shopping'
end
