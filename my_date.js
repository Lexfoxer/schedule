// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  var TZO, dictionary_DayWeek, dictionary_Months, dictionary_TimeLessons, getNumberLessonsWeek, startWeek, toDate;

  dictionary_DayWeek = {
    '0': 'Воскресенье',
    '1': 'Понедельник',
    '2': 'Вторник',
    '3': 'Среда',
    '4': 'Четверг',
    '5': 'Пятница',
    '6': 'Суббота'
  };

  dictionary_Months = {
    '0': 'Января',
    '1': 'Февраля',
    '2': 'Марта',
    '3': 'Апреля',
    '4': 'Мая',
    '5': 'Июня',
    '6': 'Июля',
    '7': 'Августа',
    '8': 'Сентября',
    '9': 'Октября',
    '10': 'Ноября',
    '11': 'Декабря'
  };

  dictionary_TimeLessons = {
    '1': '8:30-10:00',
    '2': '10:10-11:40',
    '3': '11:50-13:20',
    '4': '13:50-15:20',
    '5': '15:30-17:00',
    '6': '17:10-18:40'
  };

  startWeek = new Date(2016, 7, 28, 0, 0, 0);

  TZO = (new Date().getTimezoneOffset() * -1) * 1000 * 60;

  getNumberLessonsWeek = function(date, callback) {
    var end, start;
    if (isNaN(new Date(Date.parse(date)))) {
      callback('(getNumberLessonsWeek) Дата не верна: ' + date);
    }
    start = (startWeek.getTime()) + TZO;
    end = (new Date(date).getTime()) + TZO;
    return callback(null, Math.ceil(((end - start) / (1000 * 60 * 60 * 24)) / 7));
  };

  toDate = function(date, callback) {
    var code_week_fn, day_week, new_date;
    if (isNaN(new Date(Date.parse(date)))) {
      callback('(toDate) Дата не верна: ' + date);
    }
    new_date = new Date((new Date(date).getTime()) + TZO);
    day_week = new_date.getDay();
    code_week_fn = getNumberLessonsWeek(new_date, function(err, data) {
      if (err) {
        throw err;
      }
      console.log(day_week);
      if (day_week === 0) {
        return data - 1;
      }
      return data;
    });
    return callback(null, {
      newDate: new_date,
      dayWeek: day_week,
      codeWeek: code_week_fn,
      evenWeek: code_week_fn % 2
    });
  };

  module.exports = {
    int_week: getNumberLessonsWeek,
    dic_date: dictionary_DayWeek,
    dic_month: dictionary_Months,
    dic_timeLessons: dictionary_TimeLessons,
    to_date: toDate
  };

}).call(this);
