(function() {
  'use strict';

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['models'], function() {
    app.collections = {
      Tweets: Backbone.Collection.extend({
        model: app.Tweet,
        url: 'https://search.twitter.com/search.json?',
        sync: function(method, model, options) {
          options.timeout = 10000;
          options.dataType = "jsonp";
          return Backbone.sync(method, model, options);
        },
        parse: function(res) {
          return res.results;
        }
      }),
      StreamCollection: Backbone.Collection.extend({
        stream: function(options) {
          var _update;
          this.unsteam();
          _update = _bind(function() {
            this.fetch(options);
            return this._intervalFetch = window.setTimeout(_update, options.interval || 1000, this);
          });
          return _update();
        },
        unstream: function() {
          window.clearTimeout(this._intervalFetch);
          return delete this._intervalFetch;
        },
        isStreaming: function() {
          return _.isUndefined(this._intervalFetch);
        }
      })
    };
    app.Tweets = new app.collections.Tweets;
    return app.collections;
  });

}).call(this);
