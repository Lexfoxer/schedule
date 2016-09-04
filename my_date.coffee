'use strict'

# 
# Dictionarys
# 
dictionary_DayWeek = {
	'0': 'Воскресенье'
	'1': 'Понедельник'
	'2': 'Вторник'
	'3': 'Среда'
	'4': 'Четверг'
	'5': 'Пятница'
	'6': 'Суббота'
}

dictionary_ru_to_eng = {
	'января': 'jan'
	'февраля': 'feb'
	'марта': 'mar'
	'апреля': 'apr'
	'мая': 'may'
	'июня': 'jun'
	'июля': 'jul'
	'августа': 'aug'
	'сентября': 'sep'
	'октября': 'oct'
	'ноября': 'nov'
	'декабря': 'dec'
}

dictionary_Months = {
	'0': 'Января'
	'1': 'Февраля'
	'2': 'Марта'
	'3': 'Апреля'
	'4': 'Мая'
	'5': 'Июня'
	'6': 'Июля'
	'7': 'Августа'
	'8': 'Сентября'
	'9': 'Октября'
	'10': 'Ноября'
	'11': 'Декабря'
}

dictionary_TimeLessons = {
	'1': '8:30-10:00'
	'2': '10:10-11:40'
	'3': '11:50-13:20'
	'4': '13:50-15:20'
	'5': '15:30-17:00'
	'6': '17:10-18:40'
}


# 
# Generation time
# 

startWeek = new Date(2016, 7, 28, 0, 0, 0)	# указываем воскресенье -1 недели
startDay = new Date(2016, 8, 1, 0, 0, 0)	# Указываем 1 сентября учебного года
endDay = new Date(2017, 0, 31, 0, 0, 0)	# указываем последний день учебного семестра

TZO = (new Date().getTimezoneOffset() * -1) * 1000 * 60		# отставание UTC в миллисекундах

getNumberLessonsWeek = (date, callback)->
	if isNaN(new Date(Date.parse(date)))
		callback 'Дата не верна. Введите дату в формате: день месяц год'

	start = (startWeek.getTime()) + TZO	# указываем первую неделю
	end = (new Date(date).getTime()) + TZO	# указываем входящую дату
	callback null, Math.ceil(((end - start) / (1000 * 60 * 60 * 24)) / 7)

toDate = (date, callback)->
	if typeof date != 'object'
		arr_date = date.split(' ')
		if dictionary_ru_to_eng[arr_date[1]] != undefined && arr_date.length != 1
			date = arr_date[0]+' '+dictionary_ru_to_eng[arr_date[1]]+' '+arr_date[2]
		if arr_date[2] == undefined && arr_date.length != 1
			if dictionary_ru_to_eng[arr_date[1]] != undefined && arr_date.length != 1
				date = arr_date[0]+' '+dictionary_ru_to_eng[arr_date[1]]+' 2016'
			else
				date = arr_date[0]+' '+arr_date[1]+' 2016'

	if isNaN(new Date(Date.parse(date)))
		callback '<b>Дата не верна. Введите дату в формате: день месяц год</b>'

	in_date = new Date(date).getTime()	# полученная дата в секундах
	if in_date <= startDay.getTime() || in_date >= endDay.getTime()
		callback '<b>Дата не входит в учебный семестр. Введите дату в формате: день месяц год</b>'

	new_date = new Date((new Date(date).getTime()) + TZO)
	day_week = new_date.getDay()
	code_week_fn = getNumberLessonsWeek new_date,(err, data)->
		if err
			throw err
		if day_week == 0
			return data-1
		return data

	callback null, {
		newDate: new_date			# полная дата (UTC + 3)
		dayWeek: day_week			# день недели (int)
		codeWeek: code_week_fn		# номер недели (int)
		evenWeek: code_week_fn%2	# четность недели
	}


module.exports = {
	int_week: getNumberLessonsWeek
	dic_date: dictionary_DayWeek
	dic_month: dictionary_Months
	dic_timeLessons: dictionary_TimeLessons
	to_date: toDate
}


