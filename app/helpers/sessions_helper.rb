module SessionsHelper
	def sign_in(user)
		# request a SecureRandom base 64 pre hash
		remember_token = User.new_remember_token
		# save the remember token to the cookies so that it can be retrieved later with
		# security purposes
		cookies.permanent[:remember_token] = remember_token
		# Saves the remember token but encrypted with SHA1 digest to ensure user authentication
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def signed_in_user
		if !signed_in?
			store_location
			flash[:error] = "Please log in to perform this action"
			redirect_to signin_path
		end
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def sign_out
		current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def current_user?(user)
		user == current_user
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		begin
			session[:return_to] = request.url if request.get
		rescue Exception => e
			flash[:error] = "Couldn't retrieve adress"
			session[:return_to] = nil
		end
	end
end
