# Socket.io stuff

'use strict'
@app = window.app ? {}

define ['socket.io'], (io) ->

	socket = io.connect("http://localhost:8000")
	socket.on "news", (data) ->
		console.log data
		return '@alvaromuir says the webapp is ready.'