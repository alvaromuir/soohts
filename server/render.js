// Generated by CoffeeScript 1.6.1
(function() {
  /FiletorenderstuffAlvaroMuir,@alvaromuir/;
  var fs, jade;

  fs = require('fs');

  jade = require('jade');

  module.exports = {
    jade: function(templateFilePath, context) {
      /Thiswillreturnarenderedjadefile.Thetemplatevariableisafullpath,thecontextisanobjectthatinjectsintothetemplate./;
      var layout, template;
      layout = fs.readFileSync(templateFilePath, 'utf8');
      template = jade.compile(layout, {
        pretty: true
      });
      return template(context);
    }
  };

}).call(this);
