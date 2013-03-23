# Models

'use strict'
@app = window.app ? {}

define ['backbone'], ->
	class Tweet extends Backbone.Model
		app.Tweet = Tweet