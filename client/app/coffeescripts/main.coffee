require.config
  paths:
    jquery: '../components/jquery/jquery'
    bootstrap: 'vendor/bootstrap'
    eve:'../components/eve/eve.min'
    raphael: '//cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min'
    moment: '//cdnjs.cloudflare.com/ajax/libs/moment.js/2.0.0/moment.min.js'
  shim:
    bootstrap:
      deps: ['jquery']
      exports: 'jquery'
    raphael:
      deps: ['eve']
      exports: 'Raphael'

require ['app', 'jquery', 'bootstrap', 'raphael'], (app, $) ->
  'use strict'
  console.log app