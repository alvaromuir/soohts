(function() {

  define(['jquery', 'underscore', 'twitter', 'maps', 'form-clean'], function($, _, twitter, maps, formCleaner) {
    'use strict';
    return $(function() {
      var $count, $keywords, $locations, $map, $radius, $rsltsText, $submit, $well, radValue, _ref;
      this.app = (_ref = window.app) != null ? _ref : {};
      maps.setGlobalUserGeo({
        lat: 40.7522,
        lng: -73.9755
      });
      $keywords = $('#keywords');
      $count = $('#quantity');
      $locations = $('#locations');
      $radius = $('#radius');
      $rsltsText = $('#results-header');
      $submit = $('#submit-btn');
      $well = $('#tweet-well');
      $map = $('#map_canvas');
      radValue = {};
      $submit.on('click', function() {
        var queryObj;
        queryObj = {};
        radValue = formCleaner.setQueryRadius($radius.val().trim());
        queryObj['q'] = formCleaner.setQueryKeywords($keywords.val().trim());
        if (formCleaner.contentExists($locations)) {
          if (_.include($locations.val().trim(), 'My Current Location')) {
            queryObj['geocode'] = app.userGeo['lat'] + ',' + app.userGeo['lng'] + ',' + radValue.miles + 'mi';
            $(document).trigger('app.queryObjResults', queryObj);
          } else {
            formCleaner.setQueryLocation($locations.val().trim(), function(rslts) {
              queryObj['geocode'] = rslts.lat + ',' + rslts.lng + ',' + radValue.miles + 'mi';
              return $(document).trigger('app.queryObjResults', queryObj);
            });
          }
        } else {
          $(document).trigger('app.queryObjResults', queryObj);
        }
        if (formCleaner.contentExists($keywords) === false && formCleaner.contentExists($locations) === false && formCleaner.contentExists($radius) === false) {
          $rsltsText.show().html('Results for CBS Outdoor related Tweets :');
        }
        if (formCleaner.contentExists($keywords) === false && _.trim($('#locations').val(), '"' === 'My Current Location' && formCleaner.contentExists($radius) === false)) {
          $rsltsText.show().html('Results for CBS Outdoor related Tweets near me :');
        }
        return false;
      });
      return $(document).on('app.queryObjResults', function(e, queryObj) {
        var rslts;
        if (queryObj.geocode) {
          rslts = {
            lat: queryObj.geocode.split(',')[0],
            lng: queryObj.geocode.split(',')[1]
          };
        } else {
          rslts = {
            lat: app.userGeo.lat,
            lng: app.userGeo.lng
          };
        }
        $map.show();
        app.rsltMap = maps.createMap('map_canvas', rslts.lat, rslts.lng);
        maps.genRadius(app.rsltMap, {
          radius: radValue.meters,
          center: app.rsltMap.getCenter()
        });
        if (parseInt($count.val().trim())) {
          queryObj.rpp = $count.val();
        } else {
          queryObj.rpp = 15;
        }
        return twitter.getTweets(queryObj, function(tweets) {
          return _.each(tweets, function(tweet) {
            return twitter.cleanTweet(tweet.attributes, function(rslt) {
              return twitter.mapTweet(rslt, app.rsltMap);
            });
          });
        });
      });
    });
  });

}).call(this);
