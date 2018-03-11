class StoreController < ApplicationController
  skip_before_action :authorize
  include SessionCounter
  include CurrentCart
  before_action :set_cart
  #before_action :increment_counter, only: [:index]

  def index
  	if params[:set_locale]
  		redirect_to store_url(locale: params[:set_locale])
  	else
  	@products = Product.order(:title)
    increment_counter
  	end
	end
end