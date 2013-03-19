# Models

define ['backbone'], ->
  class Tweet extends Backbone.Model


  @app = window.app ? {}
  @app.Tweet = Tweet