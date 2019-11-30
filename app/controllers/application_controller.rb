class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	def root
		render file: 'layouts/application.html.erb'
	end
	def feed
		@users = User.all
		if params.has_key?(:filter)
			filter_str = "%"
			filter_str += params[:filter]
			filter_str += '%'
			@users = User.where("name like ?", filter_str)
		end
		render file: 'layouts/feed.html.erb'
	end
	def user
		@user = User.find_by(id: params[:id])
		@comments = @user.comments
		sum = 0.0
		@comments.each { |a| sum += a.rating }
		@aggregate_rating = (sum / @comments.size).round(1)
		render file: 'layouts/user.html.erb'
	end
	def sign_up
		User.create(name: params[:name], email: params[:email], password: params[:password])
	end
	protected
	def configure_permitted_parameters
	   attributes = [:name, :surname,:username, :email, :avatar]
	   devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
	   
	end
end
