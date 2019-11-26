class CreateComments < ActiveRecord::Migration[6.0]
	def change
    	create_table :comments do |t|
    		t.string :text, 				null: false, default: ""
    		t.integer :rating, 				null: false
    		t.integer :assigned_user,		null: false
    		t.integer :created_user,		null: false
    	end
	end
end
