///
  File to render stuff
  Alvaro Muir, @alvaromuir
///

fs   = require 'fs'
jade = require 'jade'

module.exports =
  jade: (templateFilePath, context) ->
    ///
      This will return a rendered jade file. 
      The template variable is a full path, the context is an object
      that injects into the template.
    ///
    layout = fs.readFileSync templateFilePath, 'utf8'
    template = jade.compile layout, pretty: true
    return template context
