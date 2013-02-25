fs        = require 'fs'
jade      = require 'jade'
_         = require 'lodash'
_s        = require 'underscore.string'
render    = require './render'
app       = require './server'

if typeof restify == 'undefined'
  restify = require 'restify'

if typeof config == 'undefined'
  config  = require './config'

twtr = config.twitter.init()

templates = './jade/'
postTitle = ' | Soohts'

# JSON client
client = restify.createJSONClient
      version: '*'
      url: 'http://search.twitter.com/search.json?'

# some utilities
getTemplate = (template) ->
  return templates + template + '.jade'


cleanSubmittedFilters = (arr) ->
  data = arr.replace(/\+/g, " ").split "%2C"
  rslts = []
  rslts.push _s.clean decodeURIComponent i for i in data
  return rslts

buildQueryString = (queryObj, cb) ->
  count = 0
  queryObj.q = encodeURIComponent queryObj.q
  queryString = ''
  for key in _.pairs queryObj
    queryString += key[0]+'='+key[1]+'&';
    count += 1
    if count == _.pairs(queryObj).length
      cb queryString.substring 0, queryString.length-1


twitterSearchUrl = client.url.href


# route handlers
module.exports = 
  index: (req, res) ->
    res.send {move_along: 'nothing to see here... ', follow_us: '@cbsoudoor'}
    return next()

  # filter url params
  queryFilters: (req, res, next) ->
    buildQueryString req.query, (rsltString) ->
      searchString = twitterSearchUrl + rsltString
      client.get searchString, (err, creq, cres, cobj) ->
        if err
          res.send err
        res.send cobj
        return next()