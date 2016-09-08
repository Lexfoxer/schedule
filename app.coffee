'use strict'

lessons = require './lessons'
my_date = require './my_date'
TelegramBot = require 'node-telegram-bot-api'
token = '';

tb = new TelegramBot token, {polling: true}

tb.on 'message', (msg)->
	chatId = msg.chat.id
	nDate = new Date()
	switch msg.text.toLowerCase()
		when 'позавчера'
			generation_event_new_messages chatId, new Date((nDate.getTime() - (1000*60*60*24*2)))
		when 'вчера'
			generation_event_new_messages chatId, new Date((nDate.getTime() - (1000*60*60*24)))
		when 'сегодня'
			generation_event_new_messages chatId, new Date()
		when 'завтра'
			generation_event_new_messages chatId, new Date((nDate.getTime() + (1000*60*60*24)))
		when 'послезавтра'
			generation_event_new_messages chatId, new Date((nDate.getTime() + (1000*60*60*24*2)))
		else
			generation_event_new_messages chatId, msg.text



generation_event_new_messages = (chatId, in_mess)->
	my_date.to_date in_mess,(err, out_date)->
		if err
			tb.sendMessage chatId, '<b>'+err+'</b>', {parse_mode: "HTML"}
			throw err

		lessons.day out_date.dayWeek, (err, obj_day)->
			if err
				tb.sendMessage chatId, '<b>'+err+'</b>', {parse_mode: "HTML"}
				throw err
			if obj_day.army
				return create_send_message chatId, out_date, '<b>8:30 - 17:00</b>\nВоенная кафедра'

			lessons_to_string chatId, obj_day.lessons, out_date.evenWeek, out_date.codeWeek, (err, data)->
				if err
					tb.sendMessage chatId, '<b>'+err+'</b>', {parse_mode: "HTML"}
					throw err
				return create_send_message chatId, out_date, data



lessons_to_string = (chatId, array_data, even_week, code_week, callback)->
	str_message_lessons = ''
	for key in array_data
		if key.even_week == even_week
			if key.start_week <= code_week || key.start_week == undefined
				if key.number_week.length == 0 || key.number_week.indexOf(code_week) >= 0
					out_string key, (data)->
						str_message_lessons += data
	if str_message_lessons != ""
		callback null, str_message_lessons
	else
		callback null, 'Пар нет, отдыхай'



out_string = (key, callback)->
	ret = """
		<b>#{my_date.dic_timeLessons[key.number_lesson]}</b>
		#{key.title}, #{key.class_room}
		<b>--------------------</b>\n
		"""
	if ret != ""
		callback ret



create_send_message = (chatId, out_date, data)->
	message = """
		<b>#{out_date.newDate.getDate()} #{my_date.dic_month[out_date.newDate.getMonth()]}
		#{my_date.dic_date[out_date.dayWeek]}, #{out_date.codeWeek} неделя</b>\n\n
		""" + data
	tb.sendMessage chatId, message, {parse_mode: "HTML"}






