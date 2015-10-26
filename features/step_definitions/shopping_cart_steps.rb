Given(/^there is a 'Oranges' item in the products list$/) do
  Product.create(title: "Oranges", price: 2.99, description: "Bag of 6 Valencia oranges", image_url: "oranges.jpg", stock: 50)
end

When(/^the user goes to the products URL$/) do
  visit products_path
end

Then(/^the user should see the 'Oranges' item in the product catalogue$/) do
  page.should have_content('Oranges')
end

When(/^the user clicks on the 'Oranges' link$/) do
  click_link 'Oranges'
end

Then(/^the user should see the 'Oranges' item details$/) do
  page.should have_content('Title: Oranges')
  page.should have_content('Price: $2.99')
  page.should have_content('Description: Bag of 6 Valencia oranges')
  page.should have_content('Stock: 50 In Stock')
end

Then(/^the user should see the 'Back' link$/) do
  find_link('Back').visible?
end

Then(/^the user should be able to go back to the products catalogue page$/) do
  click_link 'Back'
  expect(current_path).to eq products_path
end