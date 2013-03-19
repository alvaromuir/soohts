(function() {
  /TwitterstuffAlvaroMuir,CBSOutdoor-@alvaromuir/;

  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['jquery', 'collections', 'handlebars'], function($, collections) {
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
      }
    };
    return app.twitter;
  });

}).call(this);
