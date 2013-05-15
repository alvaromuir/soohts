(function() {
  'use strict';

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['collections'], function() {
    app.views = {
      TweetView: Backbone.View.extend({
        tagName: 'li',
        clasName: 'tweet',
        render: function() {
          $(this.el).html(this.model.get('text'));
          return this;
        }
      })
    };
    return app.views;
  });

}).call(this);
