(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone'], function() {
    var Tweet, _ref;
    Tweet = (function(_super) {

      __extends(Tweet, _super);

      function Tweet() {
        return Tweet.__super__.constructor.apply(this, arguments);
      }

      return Tweet;

    })(Backbone.Model);
    this.app = (_ref = window.app) != null ? _ref : {};
    return this.app.Tweet = Tweet;
  });

}).call(this);
