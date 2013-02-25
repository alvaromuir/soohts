# Collections

@app = window.app ? {}

define ['models'], ->
  class GrabTweets extends Backbone.Collection
    model: app.GrabTweet
    url: 'http://localhost:8000/api/response.json'

  @app.GrabTweets = new GrabTweets