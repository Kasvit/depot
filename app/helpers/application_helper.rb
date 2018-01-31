module ApplicationHelper

def date_loaded
	return Time.zone.now.strftime("%I:%M %S %p")
	#return Time.now.change(sec: 1)
end

end
