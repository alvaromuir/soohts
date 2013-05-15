(function() {
  'use strict';

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['jquery', 'moment', 'collections', 'handlebars'], function($, moment, collections) {
    Handlebars.registerHelper('daystamp', function(input) {
      return moment(input).format('MMMM Do, YYYY');
    });
    Handlebars.registerHelper('when', function(input) {
      return moment(input).fromNow();
    });
    app.twitter = {
      getTweets: function(queryObj, cb) {
        return app.Tweets.fetch({
          data: queryObj,
          success: function() {
            window.tweets = app.Tweets.models;
            cb(tweets);
            return tweets;
          }
        });
      },
      cleanTweet: function(obj, cb) {
        var rslt;
        rslt = {
          userId: obj.from_user_id,
          username: '@' + obj.from_user,
          name: obj.from_user_name,
          thumb: obj.profile_image_url_https,
          profile: 'https://twitter.com/' + obj.from_user,
          msgId: obj.id,
          text: obj.text,
          tweetUrl: 'https://twitter.com/' + obj.from_user_name + 'status/' + obj.id,
          timestamp: obj.created_at,
          geo: obj.geo,
          location: obj.location
        };
        cb(rslt);
        return rslt;
      },
      mapTweet: function(obj, map) {
        var coords, infoWindowData;
        infoWindowData = Handlebars.compile($('#tweet-map-template').html())(obj);
        if (obj.geo) {
          coords = {
            lat: obj.geo.coordinates[0],
            lng: obj.geo.coordinates[1]
          };
          app.maps.addMarkers(map, coords, infoWindowData);
        } else {
          return app.utils.geocodeAddress(obj.location, function(coords) {
            app.maps.addMarkers(map, coords, infoWindowData);
          });
        }
      },
      tableTweet: function(obj, table) {
        var rsltsTableRow;
        rsltsTableRow = Handlebars.compile($('#tweet-results-row').html())(obj);
        return table.append(rsltsTableRow);
      }
    };
    return app.twitter;
  });

}).call(this);
