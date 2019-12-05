class AddAggregateRating < ActiveRecord::Migration[6.0]
	def change
    	add_column :users, :aggregate_rating, :integer, :default => 0
	end
end
