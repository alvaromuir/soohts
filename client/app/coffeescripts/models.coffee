# Models

define ['backbone'], ->
  class GrabTweet extends Backbone.Model

  @app = window.app ? {}
  @app.GrabTweet = GrabTweet