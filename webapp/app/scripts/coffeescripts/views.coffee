# Views

'use strict'
@app = window.app ? {}

define ['collections'], ->

	app.views =
	  	TweetView: Backbone.View.extend
	  		tagName: 'li'
	  		clasName: 'tweet'
	  		render: ->
	  			$(this.el).html this.model.get 'text'
	  			return this

	return app.views
