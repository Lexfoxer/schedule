'use strict';

# 
# Add element
# 

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
# Function
# 

addDay = tress (obj, done)->
	new Day({
		day_week: obj.title
		lessons: obj.arr
		army: obj.army
	}).save (err)->
		if err
			console.error(err)
		done null, 1

addDay.drain = ()->
	console.log 'Finished'
	db.close()


# 
# Save
# 

monday_arr_lessons = [
	new Lesson({
		even_week: 1, number_lesson: 2
		title: 'Философия', class_room: '101А'
	})
	new Lesson({
		even_week: 1, number_lesson: 3
		title: 'Базы данных', class_room: '624А'
	})
	new Lesson({
		even_week: 1, number_lesson: 4
		title: 'Базы данных', class_room: '304Б'
	})
	new Lesson({
		even_week: 1, number_lesson: 5
		title: 'Базы данных', class_room: '304Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 2
		title: 'Электротехника, электроника и схемотехника', class_room: '603А'
		number_week: [4,8,12,16]
	})
	new Lesson({
		even_week: 2, number_lesson: 3
		title: 'Электротехника, электроника и схемотехника', class_room: '301В'
	})
	new Lesson({
		even_week: 2, number_lesson: 4
		title: 'Базы данных', class_room: '304Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 5
		title: 'Базы данных', class_room: '304Б'
	})
]

tuesday_arr_lessons = [
	new Lesson({
		even_week: 1, number_lesson: 2
		title: 'Философия', class_room: '430А'
	})
	new Lesson({
		even_week: 1, number_lesson: 3
		title: 'Вычислительная математика', class_room: '609А'
	})
	new Lesson({
		even_week: 1, number_lesson: 4
		title: 'Вычислительная математика', class_room: '306Б'
	})
	new Lesson({
		even_week: 1, number_lesson: 5
		title: 'Физическая культура', class_room: 'Зал'
	})
	new Lesson({
		even_week: 2, number_lesson: 3
		title: 'Вычислительная математика', class_room: '609А'
	})
	new Lesson({
		even_week: 2, number_lesson: 4
		title: 'Вычислительная математика', class_room: '306Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 5
		title: 'Физическая культура', class_room: 'Зал'
	})
]

wednesday_arr_lessons = [
	new Lesson({
		even_week: 1, number_lesson: 2
		title: 'Моделирование систем', class_room: '624А'
	})
	new Lesson({
		even_week: 1, number_lesson: 3
		title: 'Моделирование систем', class_room: '306Б'
	})
	new Lesson({
		even_week: 1, number_lesson: 4
		title: 'Моделирование систем', class_room: '306Б'
	})
	new Lesson({
		even_week: 1, number_lesson: 5
		title: 'Электротехника, электроника и схемотехника', class_room: '301В'
		number_week: [3, 7, 11, 15]
	})
	new Lesson({
		even_week: 2, number_lesson: 1
		title: 'Правоведение', class_room: '101А'
	})
	new Lesson({
		even_week: 2, number_lesson: 2
		title: 'Правоведение', class_room: '430А'
	})
	new Lesson({
		even_week: 2, number_lesson: 3
		title: 'Моделирование систем', class_room: '306Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 4
		title: 'Моделирование систем', class_room: '306Б'
	})
]

friday_arr_lessons = [
	new Lesson({
		even_week: 1, number_lesson: 2
		title: 'Физическая культура', class_room: 'Зал'
	})
	new Lesson({
		even_week: 1, number_lesson: 3
		title: 'Теория принятия решений', class_room: '304Б'
	})
	new Lesson({
		even_week: 1, number_lesson: 4
		title: 'Теория принятия решений', class_room: '304Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 2
		title: 'Физическая культура', class_room: 'Зал'
	})
	new Lesson({
		even_week: 2, number_lesson: 3
		title: 'Теория принятия решений', class_room: '304Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 4
		title: 'Теория принятия решений', class_room: '304Б'
	})
	new Lesson({
		even_week: 2, number_lesson: 5
		title: 'Теория принятия решений', class_room: '609А'
	})
]

saturday_arr_lessons = [
	new Lesson({
		even_week: 2, number_lesson: 1
		title: 'л/р Электротехника, электроника и схемотехника', class_room: '608А, 611А'
		start_week: 6
	})
	new Lesson({
		even_week: 2, number_lesson: 2
		title: 'л/р Электротехника, электроника и схемотехника', class_room: '608А, 611А'
		start_week: 6
	})
]

addDay.push [{title: "Понедельник", arr: monday_arr_lessons}]
addDay.push [{title: "Вторник", arr: tuesday_arr_lessons}]
addDay.push [{title: "Среда", arr: wednesday_arr_lessons}]
addDay.push [{title: "Четверг", arr: [], army: true}]
addDay.push [{title: "Пятница", arr: friday_arr_lessons}]
addDay.push [{title: "Суббота", arr: saturday_arr_lessons}]


