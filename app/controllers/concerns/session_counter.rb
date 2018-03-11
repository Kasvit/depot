module SessionCounter
  extend ActiveSupport::Concern

  private

  def increment_counter
  	#if session[:counter].nil?
    #	session[:counter] = 0
  	#end
  	#	session[:counter] += 1
  	# 	if session[:counter] >= 5
    #    return session[:counter]         
    # 	end
    @counter = session[:counter]
    @counter.nil? ? @counter = 1 : @counter+=1 
    session[:counter] = @counter
end
end