// Generated by CoffeeScript 1.4.0
(function() {
  var fs, getTemplate, jade, postTitle, render, templates;

  fs = require('fs');

  jade = require('jade');

  render = require('./render');

  templates = './jade/';

  postTitle = ' | Soohts';

  getTemplate = function(template) {
    return templates + template + '.jade';
  };

  module.exports = {
    index: function(req, res, next) {
      var content, context, tmpl;
      tmpl = getTemplate('index');
      context = {
        pageTitle: 'Welcome!' + postTitle
      };
      content = render.jade(tmpl, context);
      res.writeHead(200, {
        'Content-Length': content.length,
        'Content-Type': 'text/html'
      });
      return res.end(content);
    }
  };

}).call(this);
