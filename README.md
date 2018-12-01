# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
2.5.0

* Rails version
5.2.0

* Table Schema
- Model User
email:string
password:string
name:string
role:integer

- Model Task
title:string
description:string
deadline:date
priority:integer
tag:string

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
		Before deployment,install Heroku CLI: https://devcenter.heroku.com/articles/heroku-cli#download-and-install and Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git 
		Deploy to Heroku
		1. Download this project to your local repo
		2. Open your project
		$ cd "your project location"
		3. Login with Heroku account and create new App
		$ heroku login
		$ heroku create
		4. Deploy this app with Heroku CLI commands
		$ git push heroku master
		5. Initial db
		$ heroku run rails db:migrate
		6. Create User
		$ heroku run rails console
		$ User.create(email: "your emrail", password: "your password")
		$ exit
		7. open your app with Heroku CLI commands
		$ heroku open
		8. Login with User and enjoy the app!

