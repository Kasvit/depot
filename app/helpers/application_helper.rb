module ApplicationHelper

def date_loaded
	return Time.zone.now.strftime("%I:%M %S %p")
	#return Time.now.change(sec: 1)
end

def hidden_div_if(condition, attributes = {}, &block)
	if condition
		attributes["style"] = "display: none"
	end
	content_tag("div", attributes, &block)
	end

	def currency_to_locale(price)
		price = price * 26.45 if 'uk' == I18n.locale.to_s
		number_to_currency price
	end
end
