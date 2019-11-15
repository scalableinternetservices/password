class CommentController < ActionController::Base
	before_action :authenticate_user!
	skip_before_action :verify_authenticity_token

	def create
		user_id = params[:id]
		text = params[:text]
		rating = params[:rating].to_i
		creator = current_user.id
		Comment.create(assigned_user: user_id, text: text, rating: rating, created_user: creator)
		redirect_back fallback_location: '/'
	end

	def feed
		@comments = Comment.order(:created_at).reverse
		render file: 'layouts/comment_feed.html.erb'
	end
end