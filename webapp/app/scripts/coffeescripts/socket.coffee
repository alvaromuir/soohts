# Socket.io stuff

'use strict'
@app = window.app ? {}

define [], () ->
	if window.io
		socket = io.connect('http://restserv.dev:8124')
		socket.on "news", (data) ->
			console.log data
			console.log '@alvaromuir says, "The webapp is ready, too."'
		app.socket = socket
		return socket