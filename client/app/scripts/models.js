(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone'], function() {
    var GrabTweet, _ref;
    GrabTweet = (function(_super) {

      __extends(GrabTweet, _super);

      function GrabTweet() {
        return GrabTweet.__super__.constructor.apply(this, arguments);
      }

      return GrabTweet;

    })(Backbone.Model);
    this.app = (_ref = window.app) != null ? _ref : {};
    return this.app.GrabTweet = GrabTweet;
  });

}).call(this);
