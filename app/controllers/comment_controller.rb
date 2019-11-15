class CommentController < ActionController::Base
	before_action :authenticate_user!
	skip_before_action :verify_authenticity_token

	def create
		user_id = params[:id]
		text = params[:text]
		rating = params[:rating].to_i
		creator = current_user.id
		Comment.create(assigned_user: user_id, text: text, rating: rating, created_user: creator)
		comment_str = "<p>"
		comment_str += User.find_by(id: user_id).name
		comment_str += " has just rated "
		comment_str += User.find_by(id: creator).name
		comment_str += " with "
		comment_str += rating.to_s
		comment_str += "</p>"
		ActionCable.server.broadcast("web_notifications_channel", comment_str)
		redirect_back fallback_location: '/'
	end

	def feed
		@comments = Comment.order(:created_at).reverse
		render file: 'layouts/comment_feed.html.erb'
	end
end
