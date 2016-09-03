'use strict'

mongoose = require 'mongoose'
tress = require 'tress'
Schema = mongoose.Schema
mongoose.Promise = global.Promise
mongoose.connect 'mongodb://localhost:27017/MySchedule'

db = mongoose.connection
db.on 'error', console.error.bind console, 'connection error:'

Day = mongoose.model 'Day', new Schema {
		day_week: String
		lessons: [Schema.Types.Mixed]
		army: Boolean
	}

Lesson = mongoose.model 'Lesson', new Schema {
		even_week: Number
		number_lesson: Number
		title: String
		number_week: [Number]
		start_week: Number
		class_room: String
	}

# 
# Dictionary
# 
dic_date = {
	'0': 'Воскресенье'
	'1': 'Понедельник'
	'2': 'Вторник'
	'3': 'Среда'
	'4': 'Четверг'
	'5': 'Пятница'
	'6': 'Суббота'
}
now_date = new Date()


query_find = (query, callback)->
	Day.find query, (err, data)->
		if err
			callback err
		callback null, data



filter_today = ()->
	getDay = dic_date[ now_date.getDay() ]
	query_find {day_week : getDay}, (err, data)->
		if err
			throw err
		console.log data

filter_room = (string_room)->
	string_room = string_room.toString().toUpperCase()
	query_find {lessons: {$elemMatch: {class_room : string_room} }}, (err, data)->
		if err
			throw err
		console.log data
		db.close()


filter_room '304б'










