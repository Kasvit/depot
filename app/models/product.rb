class Product < ActiveRecord::Base
	validates :title, :description, :image_url, presence: true
	validates :title, uniqueness: true, length: {
  minimum: 4, too_short: "must have at least %{count} characters" 
}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'URL має вказувати на формат картинки GIF, JPG або PNG'
	}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}

def self.latest
	Product.order(:updated_at).last
end

end