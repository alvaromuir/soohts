(function() {
  'use strict';

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define([], function() {
    var socket;
    if (window.io) {
      socket = io.connect('http://restserv.dev:8124');
      socket.on("news", function(data) {
        console.log(data);
        return console.log('@alvaromuir says, "The webapp is ready, too."');
      });
      app.socket = socket;
      return socket;
    }
  });

}).call(this);
