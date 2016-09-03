'use strict'

mongoose = require 'mongoose'
tress = require 'tress'
my_date = require './my_date'

Schema = mongoose.Schema
mongoose.Promise = global.Promise
mongoose.connect 'mongodb://localhost:27017/MySchedule'

Day = require './structure.js'
	.Day
Lessons = require './structure.js'
	.Lessons

db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'


query_find = (query, callback)->
	Day.find query, (err, data)->
		if err
			callback err
		callback null, data

closeDB = (callback)->
	db.close()
	console.log 'DB MySchedule close'




filter_day = (day_week_code, callback)->
	query_find { day_week_code : day_week_code }, (err, data)->
		if err
			callback err
		callback null, data

filter_room = (string_room, callback)->
	string_room = string_room.toString().toUpperCase()
	query_find {lessons: {$elemMatch: {class_room : string_room} }}, (err, data)->
		if err
			callback err
		callback null, data

filter_object = (obj_query, callback)->
	if typeof(obj_query) != object
		callback 'no object'
	query_find obj_query, (err, data)->
		if err
			callback err
		callback null, data




module.exports = {
	day: filter_day
	room: filter_room
	object: filter_object
	close: closeDB
}





