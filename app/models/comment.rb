class Comment < ApplicationRecord
	belongs_to :user, foreign_key: 'assigned_user'
	validates :text, 
		presence: true, 
		length: { maximum: 1000 }
	validates :rating, 
		presence: true, 
		numericality: { 
			only_integer: true, 
			greater_than_or_equal_to: 0, 
			less_than_or_equal_to: 5 
		}
end
