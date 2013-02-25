(function() {

  define([], function() {
    var socket;
    socket = io.connect("http://localhost:8000");
    return socket.on("news", function(data) {
      console.log(data);
      return '@alvaromuir says the webapp is ready.';
    });
  });

}).call(this);
