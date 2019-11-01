# Team:
- Anirudh Veeraragavan - aniveera1
- Rahul Sheth - rahulssheth
- Quentin Truong - quentintruong
- Arpit Jasapara - ajasapara

# Section:
- 12pm

# Description:
- Social Ranking App. Social Media Platform with profile, individual ranking. Functionality includes ability to rank, search platform, update profile.

# Running:
- We have dockerized our application to make development easier.

First
`docker-compose build`

Then
`docker-compose run web rake db:create`

Then
`docker-compose run web rake db:migrate`

Finally
`docker-compose up`

Visit
`http://localhost:3000/`

Kill
`docker-compose down`

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
