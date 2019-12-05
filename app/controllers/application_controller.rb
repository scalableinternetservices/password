class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	def root
		render file: 'layouts/application.html.erb'
	end
	def feed
		@start_index = 0
		if params.has_key?(:page)
			@start_index = params[:page].to_i
		end
		if params.has_key?(:filter)
			filter_str = "%"
			filter_str += params[:filter]
			filter_str += '%'
			@prev_filter_str = filter_str
			@users = User.where("name like ?", filter_str).offset(@start_index*5).limit(5)
		else
			@users = User.all.offset(@start_index*5).limit(5)
		end
		render file: 'layouts/feed.html.erb'
	end
	def user
		@user = User.find_by(id: params[:id])
		@aggregate_rating = @user.aggregate_rating
		@comments = @user.comments
		if @aggregate_rating == 0 and @comments.length > 0
			@aggregate_rating = self.compute_rating({comments: @comments})
			@user.aggregate_rating = @aggregate_rating
			@user.save!
		end
		@profile = false
		render file: 'layouts/user.html.erb'
	end
	def profile
		@user = User.find_by(id: params[:id])
		@aggregate_rating = @user.aggregate_rating
		@comments = @user.comments
		if @aggregate_rating == 0 and @comments.length > 0
			@aggregate_rating = self.compute_rating({comments: @comments})
			@user.aggregate_rating = @aggregate_rating
			@user.save!
		end
		@profile = true
		render file: 'layouts/user.html.erb'
	end
	def new_connection
		user_1 = User.find_by(id: params[:id_1])
		user_2 = User.find_by(id: params[:id_2])
		if !(user_1.friends.include? user_2)
			user_1.friend_request(user_2)
			user_2.accept_request(user_1)

			list = [user_1.id, user_2.id]
			if Network.all.length == 0
				network = Network.create(tmp: 1)
				network.edges << list
				network.save!
			else
				network = Network.first 
				network.edges << list
				network.save!
			end
	    	ActionCable.server.broadcast("network_channel", list)
	    end
	end
	def network 
		@users = User.all
		if Network.all.length == 0
			@edges = []
		else
			@edges = Network.first.edges
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
	def drop
		User.delete_all
		Post.delete_all
	end
	protected
	def configure_permitted_parameters
	   attributes = [:name, :surname,:username, :email, :avatar]
	   devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
	end

	def compute_rating(params)
		comments = params[:comments]
		sum = 0.0
		comments.each { |a| sum += a.rating }
		aggregate_rating = (sum / @comments.size).round(1)
		aggregate_rating
	end
end
