# Collections

'use strict'
@app = window.app ? {}

define ['models'], ->
	
	app.collections =
		Tweets: Backbone.Collection.extend
			model: app.Tweet
			#url: 'http://restserv.dev/api/response.json'
			url: 'https://search.twitter.com/search.json?'
			sync: (method, model, options) ->  
    			options.timeout = 10000
    			options.dataType = "jsonp"
    			return Backbone.sync method, model, options

			parse: (res) ->
				return res.results

		StreamCollection: Backbone.Collection.extend
			stream: (options) ->
				this.unsteam()
				_update = _bind ->
					this.fetch options
					this._intervalFetch =  window.setTimeout _update, options.interval || 1000
					, this

				_update()

			unstream: ->
				window.clearTimeout this._intervalFetch
				delete this._intervalFetch

			isStreaming: ->
				return _.isUndefined this._intervalFetch

	app.Tweets = new app.collections.Tweets
	return app.collections