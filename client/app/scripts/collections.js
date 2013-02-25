(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['models'], function() {
    var GrabTweets;
    GrabTweets = (function(_super) {

      __extends(GrabTweets, _super);

      function GrabTweets() {
        return GrabTweets.__super__.constructor.apply(this, arguments);
      }

      GrabTweets.prototype.model = app.GrabTweet;

      GrabTweets.prototype.url = 'http://localhost:8000/api/response.json';

      return GrabTweets;

    })(Backbone.Collection);
    return this.app.GrabTweets = new GrabTweets;
  });

}).call(this);
