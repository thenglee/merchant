require "rack_session_access/capybara"

Given(/^there is an 'Oranges' item in the products list$/) do
  Product.create(title: "Oranges", price: 2.99, description: "Bag of 6 Valencia oranges", image_url: "oranges.jpg", stock: 50)
end

When(/^the user goes to the products URL$/) do
  visit products_path
end

Then(/^the user should see the 'Oranges' item in the product catalogue$/) do
  expect(page).to have_content('Oranges')
end

When(/^the user clicks on the "(.*?)" link$/) do |link_name|
  click_link link_name
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

Given(/^the user has an 'Oranges' item in the cart$/) do
  product = Product.create(title: "Oranges", price: 2.99, description: "Bag of 6 Valencia oranges", image_url: "oranges.jpg", stock: 50)
  order = Order.create(status: "unsubmitted")
  order.order_items.create(product_id: product.id, quantity: 1)

  page.set_rack_session(order_id: order.id)
end

And(/^the user is at the home page$/) do
  visit root_path
end

Then(/^the user should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end
