///
  Grabs latest CBSO tweets, pops one in.
  Fades them in a 5 second cycle rotation
  Alvaro Muir, @alvaromuir
///

@app = window.app ? {}

define ['jquery', 'collections'], ->
  'use strict'

  fadeReplace = (div, data) ->
    $this = $(div)
    $this.fadeToggle ->
      $this.html data
      $this.fadeToggle()

  cycle = (arr, speed, offset, cb) ->
    window.clearInterval window.timer if window.timer
    count = (if offset then offset else 1)
    window.timer = setInterval(->
      if count isnt arr.length
        cb arr[count]
        count += 1
      else
        count = 0
        cb arr[count]
        count += 1
    , speed)

  streamer = {
    init: (queryObj) ->
      app.GrabTweets.fetch 
        data: queryObj
        success: ->
          window.clearInterval window.timer if window.timer
          window.tweets = app.GrabTweets.models[0].attributes.results
          if tweets.length > 0

            # this is kinda hacky ... meant to show a tweet asap, starts with last
            $(".tweet").hide()
            $("#tweet-well img").fadeOut ->
              $(".tweet").html tweets[0].text
              $(".tweet").fadeIn()

            cycle tweets, 5000, 1, (tweet) ->
              fadeReplace ".tweet", tweet.text
          else
            window.clearInterval window.timer if window.timer
            $(".tweet").hide()
            $("#tweet-well img").fadeOut ->
              $(".tweet").html "no results for this query."
              $(".tweet").fadeIn()
  }
  return streamer;

  