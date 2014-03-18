
class StaticPagesController < ApplicationController
	require "execjs"

	def about
		@user = User.new(user_params)
	end

	def contact
	end

	def help
	end

	def search
	end

	def home
		@user = User.new
		@data1 = params[:something]
		@data2 = params[:stuff]
	end

	def game
		# ExecJS.eval "'red yellow blue'.split(' ')"
	end

	def scrollspy
	end

	private
		def user_params
			begin
				params.require(:user).permit(:name, :email)
			rescue Exception => e
				flash[:notice] = "no user found"
				params[:user] = nil
			end
			
		end

		def other_params
			begin
				params.permit(:something)
				params.permit(:stuff)
			rescue Exception => e
				flash[:notice] = "either something or sruff is missing"
			end
		end
end
