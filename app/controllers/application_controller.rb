class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def root
		render file: 'layouts/application.html.erb'
	end
	def feed
		@users = User.all
		render file: 'layouts/feed.html.erb'
	end
	def user
		@user = User.find_by(id: params[:id])
		render file: 'layouts/user.html.erb'
	end
end
