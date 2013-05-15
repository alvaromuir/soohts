require.config
  paths: 
    async: '../components/requirejs-plugins/src/async'
    jquery: '../components/jquery/jquery'
    bootstrap: 'vendor/bootstrap'
    eve: '../components/eve-adobe/eve.min'
    raphael: '../components/raphael/raphael-min'
    underscore: '../components/lodash/dist/lodash.underscore.min'
    'underscore.string': '../components/underscore.string/dist/underscore.string.min'
    backbone: '../components/backbone/backbone-min'
    moment: '../components/moment/min/moment.min'
    handlebars:'../components/handlebars/handlebars'

    models: 'models'
    collections: 'collections'
    routers: 'routers'
    view: 'views'
    socket: 'socket'
    maps: 'maps'

  shim:
    bootstrap: 
      deps: ['jquery']
      exports: 'jquery'
    backbone: 
      deps: ['underscore']
    underscore:
      deps: ['underscore.string']
      exports: '_',
      init: (UnderscoreString) ->
        _.mixin UnderscoreString
    raphael:
      deps: ['eve']
      exports: 'Raphael'



define 'googleMaps', ['async!http://maps.google.com/maps/api/js?v=3&sensor=false&region=US'], ->
  return window.google.maps

require ['utils', 'app', 'jquery', 'bootstrap'], (utils, app, $) ->
  'use strict'