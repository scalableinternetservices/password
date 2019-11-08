# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


f_user = User.create(
	name: 'User Feed Test 1',
	email: 'test4@gmail.com',
	profile_img_url: 'Headshot',
	password: 'rand_string',
)

s_user = User.create(
	name: 'User Feed Test 2',
	email: 'test1@gmail.com',
	profile_img_url: 'nosedive',
	password: 'rand_string_2'
)
