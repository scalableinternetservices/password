class CreateNetwork < ActiveRecord::Migration[6.0]
	def change
		create_table :network do |t|
    		t.integer :tmp, 				null: false
    	end
	end
end
