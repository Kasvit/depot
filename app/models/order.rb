class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
  #belongs_to :pay_type
  #validates :pay_type_id, presence: true

	#PAYMENT_TYPES = PaymentType.find(:all).collect {|type| [type.name]}
	PAYMENT_TYPES = [ I18n.t('activerecord.models.order.check'), I18n.t('activerecord.models.order.credit_card'), I18n.t('activerecord.models.order.purchase_order') ]
	#PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
	validates :name, :address, :email, presence: true
	validates :pay_type, inclusion: PAYMENT_TYPES

	def add_line_items_from_cart(cart)
		cart.line_items.each do |i|
			i.cart_id = nil
			line_items << i
		end
	end

	after_update :send_new_ship_email, :if => :ship_date_changed? && :no_ship_date
  after_update :send_changed_ship_email, :if => :ship_date_changed? && :ship_date_was

  def no_ship_date
    self.ship_date_was.nil?
  end

  def send_new_ship_email
    Notifier.order_shipped(self).deliver
  end

  def send_changed_ship_email
    Notifier.changed_shipping(self).deliver
  end
end