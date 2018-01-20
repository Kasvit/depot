require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products
  test "властивості товару не можуть бути пустими" do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:image_url].any?
  	assert product.errors[:price].any?
  end

  test "product must have unique title" do
  	product = Product.new(title: products(:ruby).title, description: "something", image_url: "fred.png", price: 1)
  	assert product.invalid?
  	assert_equal ["has already been taken"], product.errors[:title]
  end

  #test "product in not valid without a unique title - i18n" do
  #	product = Product.new(title: products(:ruby).title, description: "something", image_url: "fred.png", price: 1)
  #	assert product.invalid?
  #	assert_equal [I18n.translate('activerecord.errors.messages.taken')], product.errors[:title]
  #end

  test "Ціна товару має бути позитивною" do
  	product = Product.new(title: "book", description: "decr", image_url: "zzz.jpg")
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  	product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  	product.errors[:price]

   	product.price = 1
  	assert product.valid?
  end

  def new_product(image_url)
  	Product.new(title: "book", description: "descr", image_url: image_url)
  end

  #test "image_url" do
  #	ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
  #	bad = %w{ fred.doc fred.gif/more fred.gif.more }

  	ok.each do |name|
  		assert new_product(name).valid?, "#{name} shouldnt be invalid"
  	end

  	bad.eah do |name|
  		assert new_product(name).invalid?, "#{name} shouldnt be valid"
  #	end
	end
end
