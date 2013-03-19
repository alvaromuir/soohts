(function() {
  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['backbone'], function() {
    'use strict';

    var view;
    return view = {
      TweetView: Backbone.View.extend({
        tagName: 'li',
        clasName: 'tweet',
        render: function() {
          $(this.el).html(this.model.get('text'));
          return this;
        }
      })
    };
  });

}).call(this);
