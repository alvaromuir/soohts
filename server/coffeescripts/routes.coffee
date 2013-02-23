fs        = require 'fs'
jade      = require 'jade'
render    = require './render'

templates = './jade/'
postTitle = ' | Soohts'

getTemplate = (template) ->
  return templates + template + '.jade'

module.exports = 
  index: (req, res, next) ->
    tmpl = getTemplate 'index'
    context = pageTitle: 'Welcome!' + postTitle

    content = render.jade tmpl, context
      

    res.writeHead 200, 
      'Content-Length': content.length
      'Content-Type': 'text/html'
    res.end content