'use strict'

# 
# Dictionary
# 
dictionaryDate = {
	'0': 'Воскресенье'
	'1': 'Понедельник'
	'2': 'Вторник'
	'3': 'Среда'
	'4': 'Четверг'
	'5': 'Пятница'
	'6': 'Суббота'
}

TZO = (new Date().getTimezoneOffset() * -1) * 1000 * 60

getNumberLessonsWeek = (callback)->
	start = (new Date(2016, 7, 28, 0, 0, 0).getTime()) + TZO # указываем воскресенье -1 недели
	end = (new Date().getTime()) + TZO # указываем сегодняшнюю дату
	callback Math.ceil(((end - start) / (1000 * 60 * 60 * 24)) / 7)

toDate = (date, callback)->
	if isNaN(new Date(Date.parse(date)))
		callback 'Дата не верна: '+date
	else
		newDate = (new Date(date).getTime()) + TZO
		callback null, newDate


module.exports = {
	int_week: getNumberLessonsWeek
	dic_date: dictionaryDate
	to_date: toDate
}