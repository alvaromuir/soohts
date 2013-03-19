///
 Some utils for the webapp
 Alvaro Muir, CBS Outdoor -  @alvaromuir
///

@app = window.app ? {}

define ['jquery'], ($) ->
  'use strict'
  app.utils =
    echo: (ping) ->
      return ping