module StoreHelper

def price_uk(product)
 number_to_currency(product.price, unit: "грн.", format: "%n %u")
end

end
