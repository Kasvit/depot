class Product < ActiveRecord::Base
	has_many :line_items
	has_many :orders, through: :line_items
	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url, presence: true
	validates :title, uniqueness: true, length: {
  minimum: 4, too_short: "must have at least %{count} characters" }
	validates :image_url, allow_blank: true, :uniqueness => true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'URL має вказувати на формат картинки GIF, JPG або PNG'	}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}

	def self.latest
		Product.order(:updated_at).last
	end

	private
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			 return true
		else
			 erorrs.add(:base, 'існує товарна позиція')
			 return false
		end
	end

end