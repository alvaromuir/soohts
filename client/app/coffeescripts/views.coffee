# Views

@app = window.app ? {}
define ['backbone'], ->
  'use strict'
  view = 
  	TweetView: Backbone.View.extend
  		tagName: 'li'
  		clasName: 'tweet'
  		render: ->
  			$(this.el).html this.model.get 'text'
  			return this