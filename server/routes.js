// Generated by CoffeeScript 1.6.1
(function() {
  var app, buildQueryString, cleanSubmittedFilters, client, config, fs, getTemplate, jade, postTitle, render, restify, templates, twitterSearchUrl, twtr, _, _s;

  fs = require('fs');

  jade = require('jade');

  _ = require('lodash');

  _s = require('underscore.string');

  render = require('./render');

  app = require('./server');

  if (typeof restify === 'undefined') {
    restify = require('restify');
  }

  if (typeof config === 'undefined') {
    config = require('./config');
  }

  twtr = config.twitter.init();

  templates = './jade/';

  postTitle = ' | Soohts';

  client = restify.createJSONClient({
    version: '*',
    url: 'http://search.twitter.com/search.json?'
  });

  getTemplate = function(template) {
    return templates + template + '.jade';
  };

  cleanSubmittedFilters = function(arr) {
    var data, i, rslts, _i, _len;
    data = arr.replace(/\+/g, " ").split("%2C");
    rslts = [];
    for (_i = 0, _len = data.length; _i < _len; _i++) {
      i = data[_i];
      rslts.push(_s.clean(decodeURIComponent(i)));
    }
    return rslts;
  };

  buildQueryString = function(queryObj, cb) {
    var count, key, queryString, _i, _len, _ref, _results;
    count = 0;
    queryObj.q = encodeURIComponent(queryObj.q);
    queryString = '';
    _ref = _.pairs(queryObj);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      key = _ref[_i];
      queryString += key[0] + '=' + key[1] + '&';
      count += 1;
      if (count === _.pairs(queryObj).length) {
        _results.push(cb(queryString.substring(0, queryString.length - 1)));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  twitterSearchUrl = client.url.href;

  module.exports = {
    index: function(req, res) {
      res.send({
        move_along: 'nothing to see here... ',
        follow_us: '@cbsoudoor'
      });
      return next();
    },
    queryFilters: function(req, res, next) {
      return buildQueryString(req.query, function(rsltString) {
        var searchString;
        searchString = twitterSearchUrl + rsltString;
        return client.get(searchString, function(err, creq, cres, cobj) {
          if (err) {
            res.send(err);
          }
          res.send(cobj);
          return next();
        });
      });
    }
  };

}).call(this);
