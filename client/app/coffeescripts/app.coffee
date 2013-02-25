#global define
@app = window.app ? {}

define ['tweet-stream'], (stream) ->
  'use strict'
  stream.init "q":"@cbsoutdoor"

  $("#filter-form").submit (e) ->    
    $inputs = $ "#filter-form :input"
    values = {}
    $inputs.each ->
      values[this.name] = $(this).val()
    $(this)[0].reset();

    queryObj = {}
    queryObj["q"] = encodeURIComponent values.keywords

    if values.coordinates
      searchRadius = ','
      if values.radius
        searchRadius += values.radius + 'mi'
      else
        searchRadius += '1mi'
      queryObj["geocode"] = values.coordinates + searchRadius

    stream.init queryObj

    return false