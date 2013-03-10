# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin::User.create :email => "dimrsilva@gmail.com", :password => "infobits123"
Admin::User.create :email => "presidente@infobits.com", :password => "presidente123"