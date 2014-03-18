class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name,	presence: true,
						length: {minimum: 3, maximum: 30}

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true,
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password,	length: { minimum: 4 }

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
