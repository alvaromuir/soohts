# Socket.io stuff


define [], ->
  socket = io.connect("http://localhost:8000")
  socket.on "news", (data) ->
    console.log data
    return '@alvaromuir says the webapp is ready.'