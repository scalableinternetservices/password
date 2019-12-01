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
		@profile = false
		render file: 'layouts/user.html.erb'
	end
	def profile
		@user = User.find_by(id: current_user.id)
		@comments = @user.comments
		sum = 0.0
		@comments.each { |a| sum += a.rating }
		@aggregate_rating = (sum / @comments.size).round(1)
		@profile = true
		render file: 'layouts/user.html.erb'
	end
	def new_connection
		user_1 = User.find_by(id: params[:id_1])
		user_2 = User.find_by(id: params[:id_2])
		user_1.friend_request(user_2)
		user_2.accept_request(user_1)
		list = [user_1.id, user_2.id]
    	ActionCable.server.broadcast("network_channel", list)
		# Recompute everything from user 1 and broadcast that set.
	end
	def network 
		@users = User.all
		@edges = []
		@users.each do |u|
			friends = u.friends
			friends.each do |f|
				@edges << [f.id, u.id]
			end
		end
		render file: 'layouts/network.html.erb'
	end
	def sign_up
		User.create(name: params[:name], email: params[:email], password: params[:password])
	end
	def picture
		user = User.find_by(id: params[:id])
		user.avatar.attach(params[:avatar])
		redirect_to "/profile"
	end
	protected
	def configure_permitted_parameters
	   attributes = [:name, :surname,:username, :email, :avatar]
	   devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
	end
end
