module ProductsHelper

  def print_price(price)
	  number_to_currency price
  end

  def print_stock(stock, requested = 1)
    if stock <= 0
      content_tag(:span, "Out of Stock", class: "out_stock")
    else 
      content_tag(:span, "#{stock} In Stock ", class: "in_stock")
    end
  end
end
