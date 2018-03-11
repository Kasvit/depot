class User < ActiveRecord::Base
	#attr_accessible :name, :password, :password_confirmation
	validates :name, presence: true, uniqueness: true
	validates :password, presence: true
	after_destroy :ensure_an_admin_remains
 	has_secure_password

	private

	def ensure_an_admin_remains
		if User.count.zero?
			raise "last user cannot me deleted"
		end
	end
end