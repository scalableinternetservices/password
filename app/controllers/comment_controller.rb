class CommentController < ActionController::Base
	before_action :authenticate_user!
	skip_before_action :verify_authenticity_token

	def create
		user_id = params[:id]
		text = params[:text]
		rating = params[:rating].to_i
		creator = current_user.id
		Comment.create(assigned_user: user_id, text: text, rating: rating, created_user: creator)
		assigned_user = User.find_by(user_id)
		assigned_user.aggregate_rating = ((assigned_user.aggregate_rating * assigned_user.comments.length) + rating) / (assigned_user.comments.length + 1)
		assigned_user.save! 
		comment_str = "<div class='card'><p>"
		comment_str += User.find_by(id: user_id).name
		comment_str += " has just rated "
		comment_str += User.find_by(id: creator).name
		comment_str += " with "
		comment_str += rating.to_s
		comment_str += "</p></div>"
		ActionCable.server.broadcast("comment_channel", comment_str)
		redirect_back fallback_location: '/'
	end
	def feed
		@comments = Comment.order(:created_at).reverse
		render file: 'layouts/comment_feed.html.erb'
	end
end