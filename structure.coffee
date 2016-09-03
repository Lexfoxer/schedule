# 
# Structure DB
# 
mongoose = require 'mongoose'
Schema = mongoose.Schema
mongoose.Promise = global.Promise

Day = mongoose.model 'Day', new Schema {
		day_week_code: Number
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

module.exports = {
	Day: Day
	Lesson: Lesson
}