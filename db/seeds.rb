# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user_list = []
1000.times { |n|
	user = {}
	user[:name] = "seed-#{n}"
	user[:email] = "seed-#{n}@gmail.com"
	user[:password] = "seed-#{n}123!"
	user_list << user
}

user_list.each { |n| 
	ActiveRecord::Base.connection.execute("INSERT INTO users (name, email, encrypted_password, created_at, updated_at) VALUES ('#{n[:name]}', '#{n[:email]}', '#{n[:password]}', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
}

500.times { |comment_num| 
	ActiveRecord::Base.connection.execute("INSERT INTO comments (text, rating, assigned_user, created_user, created_at, updated_at) VALUES ('hello', 4, #{comment_num}, #{comment_num+1}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
}

