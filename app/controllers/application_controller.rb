class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def root
		render file: 'layouts/application.html.erb'
	end
end
