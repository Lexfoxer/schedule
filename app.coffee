'use strict'

lessons = require './lessons'
my_date = require './my_date'
TelegramBot = require 'node-telegram-bot-api'
token = '';

tb = new TelegramBot token, {polling: true}

tb.on 'message', (msg)->
	chatId = msg.chat.id
	console.log msg.text

	my_date.to_date msg.text,(err, out_date)->
		if err
			throw err

		lessons.day new Date(out_date).getDay(), (err, data)->
			if err
				throw err
			console.log data

