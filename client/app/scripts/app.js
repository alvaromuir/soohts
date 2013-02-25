(function() {
  var _ref;

  this.app = (_ref = window.app) != null ? _ref : {};

  define(['tweet-stream'], function(stream) {
    'use strict';
    stream.init({
      "q": "@cbsoutdoor"
    });
    return $("#filter-form").submit(function(e) {
      var $inputs, queryObj, searchRadius, values;
      $inputs = $("#filter-form :input");
      values = {};
      $inputs.each(function() {
        return values[this.name] = $(this).val();
      });
      $(this)[0].reset();
      queryObj = {};
      queryObj["q"] = encodeURIComponent(values.keywords);
      if (values.coordinates) {
        searchRadius = ',';
        if (values.radius) {
          searchRadius += values.radius + 'mi';
        } else {
          searchRadius += '1mi';
        }
        queryObj["geocode"] = values.coordinates + searchRadius;
      }
      stream.init(queryObj);
      return false;
    });
  });

}).call(this);
