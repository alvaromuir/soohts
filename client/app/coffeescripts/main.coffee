require.config

  paths:
    jquery: '//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min'
    bootstrap: 'vendor/bootstrap'
    eve:'../components/eve/eve.min'
    lodash: '//cdnjs.cloudflare.com/ajax/libs/lodash.js/1.0.1/lodash.min'
    backbone: '//cdnjs.cloudflare.com/ajax/libs/backbone.js/0.9.10/backbone-min'
    raphael: '//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min'
    moment: '//cdnjs.cloudflare.com/ajax/libs/moment.js/2.0.0/moment.min.js'
    handlebars:'//cdnjs.cloudflare.com/ajax/libs/handlebars.js/1.0.0-rc.3/handlebars.min'
    models: 'models'
    collections: 'collections'
    routers: 'routers'
    view: 'views'
    socket: 'socket'

  shim:
    bootstrap:
      deps: ['jquery']
      exports: 'jquery'
    backbone:
      deps: ['lodash']
    raphael:
      deps: ['eve']
      exports: 'Raphael'

require ['app', 'jquery', 'bootstrap'], (app, $) ->
  'use strict'