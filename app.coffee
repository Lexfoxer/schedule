'use strict'

lessons = require './lessons'
my_date = require './my_date'
TelegramBot = require 'node-telegram-bot-api'
token = '';

tb = new TelegramBot token, {polling: true}

tb.on 'message', (msg)->
	chatId = msg.chat.id

	switch msg.text.toLowerCase()

		when 'сегодня'
			my_date.to_date new Date(),(err, out_date)->
				console.log out_date
				lessons.day out_date.dayWeek, (err, obj_day)->
					if err
						throw err
					lessons_to_string chatId, obj_day.lessons, out_date.evenWeek, out_date.codeWeek, (err, data)->
						if err
							throw err
						message = """
							<b>Сегодня #{out_date.newDate.getDate()} #{my_date.dic_month[out_date.newDate.getMonth()]}\n
							#{my_date.dic_date[out_date.dayWeek]}, #{out_date.codeWeek} неделя</b>\n\n
							""" + data
						tb.sendMessage chatId, message, {parse_mode: "HTML"}


		else
			my_date.to_date msg.text,(err, out_date)->
				if err
					tb.sendMessage chatId, err
					throw err
				console.log out_date

				lessons.day out_date.dayWeek, (err, obj_day)->
					if err
						throw err
					lessons_to_string chatId, obj_day.lessons, out_date.evenWeek, out_date.codeWeek, (err, data)->
						if err
							throw err
						message = """
							<b>#{out_date.newDate.getDate()} #{my_date.dic_month[out_date.newDate.getMonth()]}
							#{my_date.dic_date[out_date.dayWeek]}, #{out_date.codeWeek} неделя</b>\n\n
							""" + data
						tb.sendMessage chatId, message, {parse_mode: "HTML"}




lessons_to_string = (chatId, array_data, even_week, code_week, callback)->
	out = ''
	for key in array_data
		if key.even_week == even_week
			#№#{key.number_lesson} 
			out += """
				<b>#{my_date.dic_timeLessons[key.number_lesson]}</b>
				#{key.title}, #{key.class_room}
				<b>--------------------</b>\n
				"""
	if out != ""
		callback null, out
	else
		callback null, 'Пар нет, отдыхай'















