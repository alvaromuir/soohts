(function() {
  /GrabslatestCBSOtweets,popsonein.Fadesthemina5secondcyclerotationAlvaroMuir,@alvaromuir/;

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['jquery', 'collections'], function() {
    'use strict';

    var cycle, fadeReplace, streamer;
    fadeReplace = function(div, data) {
      var $this;
      $this = $(div);
      return $this.fadeToggle(function() {
        $this.html(data);
        return $this.fadeToggle();
      });
    };
    cycle = function(arr, speed, offset, cb) {
      var count;
      if (window.timer) {
        window.clearInterval(window.timer);
      }
      count = (offset ? offset : 1);
      return window.timer = setInterval(function() {
        if (count !== arr.length) {
          cb(arr[count]);
          return count += 1;
        } else {
          count = 0;
          cb(arr[count]);
          return count += 1;
        }
      }, speed);
    };
    streamer = {
      init: function(queryObj) {
        return app.GrabTweets.fetch({
          data: queryObj,
          success: function() {
            if (window.timer) {
              window.clearInterval(window.timer);
            }
            window.tweets = app.GrabTweets.models[0].attributes.results;
            if (tweets.length > 0) {
              $(".tweet").hide();
              $("#tweet-well img").fadeOut(function() {
                $(".tweet").html(tweets[0].text);
                return $(".tweet").fadeIn();
              });
              return cycle(tweets, 5000, 1, function(tweet) {
                return fadeReplace(".tweet", tweet.text);
              });
            } else {
              if (window.timer) {
                window.clearInterval(window.timer);
              }
              $(".tweet").hide();
              return $("#tweet-well img").fadeOut(function() {
                $(".tweet").html("no results for this query.");
                return $(".tweet").fadeIn();
              });
            }
          }
        });
      }
    };
    return streamer;
  });

}).call(this);
