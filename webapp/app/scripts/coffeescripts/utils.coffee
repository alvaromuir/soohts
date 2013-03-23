# Some basic utils for the webapp

'use strict'
@app = window.app ? {}

define ['jquery'], ($) ->

  app.utils =
    echo: (ping) ->
      return ping

	cycle = (arr, speed, offset, cb) ->
		window.clearInterval window.timer if window.timer
		count = (if offset then offset else 1)
		window.timer = setInterval(->
			if count isnt arr.length
				cb arr[count]
				count += 1
			else
				count = 0
				cb arr[count]
				count += 1
		, speed)