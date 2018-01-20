class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :title, uniqueness: true
	validates :description
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'URL має вказувати на формат картинки GIF, JPG або PNG'
	}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
end